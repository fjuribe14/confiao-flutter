import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterCtrl extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxInt index = 0.obs;
  RxBool textVisible = false.obs;
  RxBool textVisibleConfirm = false.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final identificacionController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  PageController pageController = PageController(initialPage: 0);
  RxList<Map<String, dynamic>> errors = <Map<String, dynamic>>[{}].obs;

  List<Widget> pages = const [
    RegisterOne(),
    RegisterTwo(),
  ];

  skip() {
    Get.offAllNamed(AppRouteName.authLogin);
  }

  back() {
    pageController.previousPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  next() async {
    try {
      if (index.value == 0) {
        await signUp();

        pageController.nextPage(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        skip();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  signUp() async {
    try {
      AuthCtrl authCtrl = Get.find<AuthCtrl>();

      await authCtrl.signUp(
        data: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "password_confirmation": passwordConfirmController.text.trim(),
          "name": nameController.text.trim(),
          "username": emailController.text.trim(),
          "client_id": dotenv.env['CLIENT_ID'],
          "tx_atributo": {
            "redirect_to": null,
            "tx_nombre": firstNameController.text.trim(),
            "tx_apellido": lastNameController.text.trim(),
            "tx_telefono": phoneController.text.trim(),
            "fe_nacimiento": null,
            "id_cliente": null,
            "co_identificacion":
                identificacionController.text.trim().split(' ').join(''),
            "scheme_id": await Helper()
                .getSchemeName(identificacionController.text.trim()),
            "tx_genero": null,
            "bo_pep": false,
            "tx_pais": null,
            "tx_estado": null,
            "tx_municipio": null,
            "tx_parroquia": null,
            "tx_calle": null,
            "tx_direccion": null
          }
        },
      );
    } catch (e) {
      debugPrint('$e');
      throw Exception(e);
    }
  }
}
