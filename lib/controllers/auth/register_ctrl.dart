import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCtrl extends GetxController {
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
}
