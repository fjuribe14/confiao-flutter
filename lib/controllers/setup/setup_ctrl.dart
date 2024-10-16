import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetupCtrl extends GetxController {
  RxInt index = 0.obs;
  RxBool loading = true.obs;
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  final PageController pageController = PageController();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  List<Widget> pages = const [
    // TODO: Paso 1 editar usuario
    Center(child: Text('Paso 1: Editar usuario')),
    // TODO: Paso 2 refrescar contraseña
    Center(child: Text('Paso 2: Refrescar contraseña')),
  ];
}
