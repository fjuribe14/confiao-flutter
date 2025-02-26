import 'package:confiao/controllers/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ClaimUsername extends StatelessWidget {
  const ClaimUsername({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl ctrl = Get.find<AuthCtrl>();

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Container(
            height: 5,
            width: Get.width / 3,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: Responsive.width(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Get.theme.primaryColor.withValues(alpha: 0.1),
              ),
              child: TextFormField(
                cursorColor: Get.theme.primaryColor,
                controller: ctrl.usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: '@gmail.com',
                  border: InputBorder.none,
                  label: Text('Correo electrónico'),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRouteName.authResetPassword);
              },
              child: Container(
                width: double.infinity,
                height: Responsive.width(16.0),
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
                    'Si, éste es mi usuario',
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: Get.theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
