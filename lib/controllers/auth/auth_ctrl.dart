import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCtrl extends GetxController {
  Helper helper = Helper();
  Validations validations = Validations();
  AlertService alertService = AlertService();
  HandleErrors handleErrors = HandleErrors();
  DeviceInfoService deviceInfoService = DeviceInfoService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  dynamic location;
  Client? currentUser;
  List codSchemeJson = [];
  RxBool loading = false.obs;
  RxBool isDarkMode = false.obs;
  RxBool textVisible = false.obs;
  Rx<String> appVersion = '1.0.0'.obs;

  RxBool biometricPermission = false.obs;
  RxBool canAuthWithBiometric = false.obs;
  bool actBiometryLogin = false, tokenExpired = false;
  RxInt timePassedLastActivity = 0.obs, timeValidateLastActivity = 0.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await load();
  }

  Future<void> load() async {
    appVersion.value = await helper.getAppBuildVersion();

    final String? username = await secureStorage.read(
      key: StorageKeys.storageItemUserUsername,
    );

    final String? password = await secureStorage.read(
      key: StorageKeys.storageItemUserPassword,
    );

    canAuthWithBiometric.value = await LocalAuth().getBiometricPermission();

    biometricPermission.value = canAuthWithBiometric.value &&
        !['', null].contains(username) &&
        !['', null].contains(password);

    if (username != null) {
      usernameController.text = username;
    }
  }

  _setInitialScreen(Client? user) async {
    if (user == null && Get.currentRoute != AppRouteName.login) {
      Get.offAllNamed(AppRouteName.login);
    } else if (user is Client && Get.currentRoute != AppRouteName.home) {
      Get.offAllNamed(
        AppRouteName.home,
        arguments: {'check_biometri': true},
      );
    }
  }

  Future<bool> _checkCredentials(String email, String password) async {
    try {
      final resp = await Http().http(showLoading: true).then(
            (value) => value.post(
              ApiUrl.apiRestEndPointUserCheckCredentials,
              data: jsonEncode({
                "scope": '*',
                "username": email,
                "grant_type": "password",
                "secret": Environments.secret,
                "client_id": Environments.clientId,
                "password": Helper().stringToBase64.encode(password),
              }),
            ),
          );

      final valid = resp.data?['valid'];

      return valid;
    } catch (e) {
      return false;
    }
  }

  Future login({dynamic password}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (loginFormKey.currentState!.validate() || password != null) {
      loading.value = true;

      final resp = await Http().http(showLoading: true).then(
            (value) => value.post(
              ApiUrl.apiRestEndPointLogin,
              data: {
                "scope": "*",
                "grant_type": "password",
                "secret": Environments.secret,
                "client_id": Environments.clientId,
                "username": usernameController.text.toLowerCase(),
                "password": Helper()
                    .stringToBase64
                    .encode(password ?? passwordController.text),
              },
            ),
          );

      if (resp.data?['access_token'] != null &&
          resp.data?['refresh_token'] != null &&
          resp.data?['expires_in'] != null &&
          resp.data?['roles'] != null) {
        await secureStorage.write(
          value: usernameController.text,
          key: StorageKeys.storageItemUserUsername,
        );

        if (passwordController.text.isNotEmpty) {
          await secureStorage
              .write(
                value: passwordController.text,
                key: StorageKeys.storageItemUserPassword,
              )
              .whenComplete(() => passwordController.clear());
        }

        // await globalController.startSessionUser();

        await setCurrentUser(resp.data);

        loading.value = false;

        await _setInitialScreen(currentUser);
      } else if (resp.data['success'] != null) {
        alertService.showDialog(
          title: resp.data['success'],
          subtitle: resp.data['message'],
          content: [],
          actions: [
            // CustomRoundedButton(text: 'ok'.tr, press: () => Get.back())
          ],
        );

        loading.value = false;

        passwordController.clear();
      } else {
        loading.value = false;
      }
    }
  }

  Future loginLocalAuth() async {
    LocalAuth localAuth = LocalAuth();
    FocusManager.instance.primaryFocus?.unfocus();

    bool authenticated = await localAuth.authenticate();

    if (authenticated) {
      final String? password = await secureStorage.read(
        key: StorageKeys.storageItemUserPassword,
      );

      return await login(password: password);
    }

    return alertService.showSnackBar(
      title: 'Imposible validar al usuario',
      body:
          'Por favor accede con tu contraseña, e intenta configurar la biometría nuevamente',
    );
  }

  Future<Client?> setCurrentUser(data) async {
    // var typeAccess =
    //     await secureStorage.read(key: StorageKeys.storageItemTypeAccess);

    // var hasBiometry =
    //     await secureStorage.read(key: StorageKeys.storageItemBiometry);

    // if (hasBiometry == 'true') {}

    // data['type_access'] = typeAccess;

    // await secureStorage.write(
    //   key: StorageKeys.storageItemAuthData,
    //   value: json.encode(data),
    // );

    // if (data['fecha_actual'] != null) {
    //   await secureStorage.write(
    //     key: StorageKeys.storageItemDateServer,
    //     value: data['fecha_actual'],
    //   );
    // }

    await getCurrentUser();

    return currentUser;
  }

  Future<Client?> getCurrentUser() async {
    // var data = await secureStorage.read(
    //   key: StorageKeys.storageItemAuthData,
    // );

    secureStorage
        .readAll()
        .then((value) => log('setCurrentUser readAll $value'));

    // if (data != null) {
    //   try {
    //     var userData = helper.tryParseJwt(jsonDecode(data)?['access_token']);

    //     currentUser = Client.fromJson(userData['user']);
    //     currentUser?.id = int.parse(userData['sub']);

    //     usernameController.text = currentUser!.username;
    //   } catch (e) {
    //     debugPrint('$e');
    //     await const FlutterSecureStorage().delete(
    //       key: StorageKeys.storageItemAuthData,
    //     );

    //     if (Get.currentRoute != AppRouteName.login) {
    //       Get.offAllNamed(AppRouteName.login);
    //     }
    //   }

    //   update();
    // }

    return currentUser;
  }

  Future<bool> claimPassword({bool? state = false}) async {
    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        actionsPadding:
            const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        title: Text(
          'Nesecitamos verificar que eres tú',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          width: double.infinity,
          height: Get.height * 0.075,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Get.theme.primaryColor.withOpacity(0.1),
          ),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText: !textVisible.value,
                    cursorColor: Get.theme.primaryColor,
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: '**********',
                      border: InputBorder.none,
                      label: Text('Contraseña'),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    textVisible.value = !textVisible.value;
                  },
                  child: SizedBox(
                    width: Get.height * 0.075,
                    height: Get.height * 0.075,
                    child: Icon(
                      textVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                      color: Get.theme.primaryColor.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.back(result: false),
                  child: Container(
                    width: double.infinity,
                    height: Get.height * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Get.theme.primaryColor.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final user = await getCurrentUser();
                    final isValid = await _checkCredentials(
                        user!.username, passwordController.text);

                    if (isValid && state == true) {
                      await secureStorage.write(
                          key: StorageKeys.storageItemUserUsername,
                          value: user.username);

                      await secureStorage.write(
                          key: StorageKeys.storageItemUserPassword,
                          value: passwordController.text);
                    }

                    Get.back(result: isValid);
                  },
                  child: Container(
                    width: double.infinity,
                    height: Get.height * 0.075,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Get.theme.buttonTheme.colorScheme!.secondary,
                          Get.theme.primaryColorDark,
                        ],
                        end: Alignment.topRight,
                        begin: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Continuar',
                        style: Get.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
