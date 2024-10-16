import 'package:confiao/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl ctrl = Get.find<AuthCtrl>();

    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.vertical,
          child: Container(
            width: Get.width,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const SafeArea(
              child: Column(children: <Widget>[]),
            ),
          ),
        ),
      ),
    );
  }
}
