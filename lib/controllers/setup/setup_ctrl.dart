import 'package:confiao/models/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetupCtrl extends GetxController {
  RxInt index = 0.obs;
  RxBool loading = true.obs;
  RxBool textVisible = false.obs;
  RxBool textVisibleComfirm = false.obs;
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  final PageController pageController = PageController();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final identificacionController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final nameDisabled = false.obs;
  final emailDisabled = false.obs;
  final phoneDisabled = false.obs;
  final passwordDisabled = false.obs;
  final usernameDisabled = false.obs;
  final lastNameDisabled = false.obs;
  final firstNameDisabled = false.obs;
  final identificacionDisabled = false.obs;
  final passwordConfirmDisabled = false.obs;

  final selectedTerminos = false.obs;
  final selectedPrivacidad = false.obs;

  List<Widget> pages = const [
    SetupOne(),
    SetupFour(),
    // SetupThree(),
  ];

  void skip() async {
    authCtrl.logout().whenComplete(() {
      Get.offAllNamed(AppRouteName.authLogin);
    });
  }

  void back() {
    pageController.previousPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void next() async {
    if (index.value == 0) {
      try {
        final sub = await Helper().getTokenSub();
        final refreshToken = await Helper().getRefreshToken();

        await Http().http(showLoading: true).then((value) async => value.patch(
              '${dotenv.env['URL_API_AUTH']}${ApiUrl.authProfile}/$sub',
              data: UserPerfil(
                  roles: [],
                  active: true,
                  keepSessionAlive: '1',
                  name: nameController.text,
                  stVerificado: 'VERIFICADO',
                  email: emailController.text,
                  username: emailController.text,
                  txAtributo: TxAtributo(
                    email: emailController.text,
                    txTelefono: phoneController.text,
                    txNombre: firstNameController.text,
                    txApellido: lastNameController.text,
                    coIdentificacion: identificacionController.text,
                    stVerificado: 'VERIFICADO',
                    schemeId: await Helper()
                        .getSchemeName(identificacionController.text),
                  )),
            ));

        await Http().http(showLoading: true).then((value) async => value.post(
              '${dotenv.env['URL_API_AUTH']}${ApiUrl.authRefreshSession}',
              data: RefreshSession(
                grantType: 'refreshToken',
                refreshToken: refreshToken,
                clientId: dotenv.env['CLIENT_ID'],
                secret: dotenv.env['CLIENT_SECRET'],
              ),
            ));

        pageController.nextPage(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
        );
      } catch (e) {
        debugPrint('$e');
      }
    }

    if (index.value == 1) {
      Get.offAllNamed(AppRouteName.home);
    }
  }
}
