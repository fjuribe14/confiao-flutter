import 'package:confiao/controllers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/index.dart';

class RegisterCtrl extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxInt index = 0.obs;
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

  next() {
    if (index.value == pages.length - 1) {
      Get.offAllNamed(AppRouteName.authLogin);
      return;
    }

    index.value = pageController.page!.toInt() + 1;

    pageController.nextPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  signUp() async {
    try {
      AuthCtrl authCtrl = Get.find<AuthCtrl>();

      await authCtrl.signUp(data: {
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": passwordConfirmController.text,
        "name": nameController,
        "username": emailController.text,
        "client_id": dotenv.env['CLIENT_ID'],
        "tx_atributo": {
          "redirect_to": null,
          "tx_nombre": firstNameController.text,
          "tx_apellido": lastNameController.text,
          "tx_telefono": phoneController.text,
          "fe_nacimiento": null,
          "id_cliente": null,
          "co_identificacion": identificacionController.text,
          "scheme_id":
              await Helper().getSchemeName(identificacionController.text),
          "tx_genero": null,
          "bo_pep": false,
          "tx_pais": null,
          "tx_estado": null,
          "tx_municipio": null,
          "tx_parroquia": null,
          "tx_calle": null,
          "tx_direccion": null
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }
}
