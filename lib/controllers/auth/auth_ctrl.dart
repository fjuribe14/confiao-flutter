import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCtrl extends GetxController {
  Helper helper = Helper();
  AlertService alertService = AlertService();
  DeviceInfoService deviceInfoService = DeviceInfoService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  User? currentUser;
  RxBool loading = false.obs;
  RxBool textVisible = false.obs;
  RxInt indexResetPassword = 0.obs;
  Rx<String> appVersion = '1.0.0'.obs;
  RxBool textVisibleComfirm = false.obs;
  ScrollController scrollController = ScrollController();
  PageController pageControllerResetPassword = PageController();

  RxBool biometricPermission = false.obs;
  RxBool canAuthWithBiometric = false.obs;

  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final resetPasswordCodeController = TextEditingController();

  List<Widget> pagesResetPassword = const [
    ResetPasswordOne(),
    ResetPasswordTwo(),
    ResetPasswordThree(),
  ];

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  Future<void> _setInitialScreen() async {
    final user = await getCurrentUser();

    if (user == null && Get.currentRoute != AppRouteName.authLogin) {
      Get.offAllNamed(AppRouteName.authLogin);
    } else if (user != null && Get.currentRoute != AppRouteName.home) {
      // if (user.stVerificado == 'VERIFICADO') {
        Get.offAllNamed(AppRouteName.home);
      // } else {
      //   Get.offAllNamed(AppRouteName.setup);
      // }
    }
  }

  Future<bool> _checkCredentials(String email, String password) async {
    try {
      final resp = await Http().http(showLoading: true).then(
            (value) => value.post(
              '${dotenv.env['URL_API_AUTH']}${ApiUrl.authCheckCredentials}',
              data: jsonEncode({
                "scope": '*',
                "username": email,
                "grant_type": "password",
                "client_id": dotenv.env['CLIENT_ID'],
                "secret": dotenv.env['CLIENT_SECRET'],
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

  Future<void> init() async {
    await _setInitialScreen();

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

  Future<User?> getCurrentUser() async {
    String? token = await helper.getToken();

    if (token == null) return null;

    currentUser = User.fromJson(JWT.decode(token).payload['user']);

    await secureStorage.write(
        key: StorageKeys.storageItemUserVerify,
        value: '${currentUser?.stVerificado == 'VERIFICADO'}');

    return currentUser;
  }

  Future login({dynamic password}) async {
    loading.value = true;

    final res = await Http().http(showLoading: true).then(
          (value) => value.post(
            '${dotenv.env['URL_API_AUTH']}${ApiUrl.authLogin}',
            data: {
              "scope": "*",
              "grant_type": "password",
              "secret": dotenv.env['CLIENT_SECRET'],
              "client_id": dotenv.env['CLIENT_ID'],
              "username": usernameController.text.toLowerCase(),
              "password": Helper()
                  .stringToBase64
                  .encode(password ?? passwordController.text),
            },
          ),
        );

    if (res.data != null) {
      /** save access token */
      await secureStorage.write(
        key: StorageKeys.storageItemUserToken,
        value: res.data['access_token'],
      );

      /** save refresh token */
      await secureStorage.write(
        key: StorageKeys.storageItemUserRefreshToken,
        value: res.data['refresh_token'],
      );

      /** save roles */
      await secureStorage.write(
        key: StorageKeys.storageItemUserRoles,
        value: jsonEncode(res.data['roles']),
      );

      /** save username */
      await secureStorage.write(
        value: usernameController.text,
        key: StorageKeys.storageItemUserUsername,
      );

      /** save password */
      if (passwordController.text.isNotEmpty) {
        await secureStorage
            .write(
              value: passwordController.text,
              key: StorageKeys.storageItemUserPassword,
            )
            .whenComplete(passwordController.clear);
      }
    }

    loading.value = false;

    await _setInitialScreen();
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

  Future<void> resetPasswordStepOne() async {
    try {
      alertService.showLoading(true);

      await Dio().post(
        '${dotenv.env['URL_API_AUTH']}${ApiUrl.authPasswordCreate}',
        data: {
          "username": usernameController.text.isNotEmpty
              ? usernameController.text
              : currentUser?.email,
        },
      );
    } catch (e) {
      debugPrint('$e');
      alertService.showSnackBar(title: 'Error', body: 'Correo inválido');
      throw Exception('Código inválido');
    } finally {
      alertService.showLoading(false);
    }
  }

  Future<void> resetPasswordStepTwo() async {
    try {
      alertService.showLoading(true);

      await Dio().post(
        '${dotenv.env['URL_API_AUTH']}${ApiUrl.authPasswordValidate}',
        data: {
          "username": usernameController.text.isNotEmpty
              ? usernameController.text
              : currentUser?.email,
          "token": resetPasswordCodeController.text,
        },
      );
    } catch (e) {
      debugPrint('$e');
      alertService.showSnackBar(title: 'Error', body: 'Código inválido');
      throw Exception('Código inválido');
    } finally {
      alertService.showLoading(false);
    }
  }

  Future<void> resetPasswordStepThree() async {
    try {
      alertService.showLoading(true);

      await Dio().post(
        '${dotenv.env['URL_API_AUTH']}${ApiUrl.authPasswordReset}',
        data: {
          "username": usernameController.text.isNotEmpty
              ? usernameController.text
              : currentUser?.email,
          "token": resetPasswordCodeController.text,
          "password": Helper().stringToBase64.encode(passwordController.text),
          "password_confirmation":
              Helper().stringToBase64.encode(passwordConfirmController.text),
        },
      );

      bool authenticated = await LocalAuth().authenticate();

      if (authenticated) {
        await secureStorage.write(
          key: StorageKeys.storageItemUserPassword,
          value: passwordController.text,
        );
      }

      alertService.showSnackBar(
          title: 'Contraseña actualizada',
          body: 'Tu contraseña ha sido actualizada');

      alertService.showLoading(false);

      textVisible.value = false;
      textVisibleComfirm.value = false;

      passwordController.clear();
      passwordConfirmController.clear();
      resetPasswordCodeController.clear();

      await Get.toNamed(AppRouteName.home);
    } catch (e) {
      debugPrint('$e');
      alertService.showLoading(false);
      alertService.showSnackBar(
          title: 'Error', body: 'No se pudo actualizar la contraseña');
      throw Exception('No se pudo actualizar la contraseña');
    }
  }

  skipResetPassword() {
    Get.back();
  }

  backResetPassword() {
    pageControllerResetPassword.previousPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  nextResetPassword() async {
    try {
      if (indexResetPassword.value == 0) {
        await resetPasswordStepOne();
        pageControllerResetPassword.nextPage(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
        );
      }

      if (indexResetPassword.value == 1) {
        await resetPasswordStepTwo();
        pageControllerResetPassword.nextPage(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
        );
      }

      if (indexResetPassword.value == 2) {
        await resetPasswordStepThree();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future signUp({required Map<String, dynamic> data}) async {
    try {
      final res = await Http().http(showLoading: true).then(
            (value) => value.post(
                '${dotenv.env['URL_API_AUTH']}${ApiUrl.authSignup}',
                data: data),
          );

      debugPrint(res.data.toString());
    } catch (e) {
      debugPrint('$e');
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      alertService.showLoading(true);

      /** get logout url */
      await Dio().get(
        '${dotenv.env['URL_API_AUTH']}${ApiUrl.authLogout}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await helper.getToken()}',
          },
        ),
      );
    } catch (e) {
      debugPrint('$e');
    } finally {
      alertService.showLoading(false);

      /** delete access token */
      await secureStorage.delete(key: StorageKeys.storageItemUserToken);

      /** delete refresh token */
      await secureStorage.delete(key: StorageKeys.storageItemUserRefreshToken);

      /** delete roles */
      await secureStorage.delete(key: StorageKeys.storageItemUserRoles);

      /** set initial screen */
      await init();
    }
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
          'Necesitamos verificar que eres tú',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          width: double.infinity,
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
                        user!.username!, passwordController.text);

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
                          Get.theme.primaryColor,
                          Get.theme.colorScheme.secondary,
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
