import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
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

  List<Widget> pages = const [
    SetupOne(),
    SetupThree(),
    SetupTwo(),
  ];

  void back() {
    pageController.previousPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void next() {
    pageController.nextPage(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
