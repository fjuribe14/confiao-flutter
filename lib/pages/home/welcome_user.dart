import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl authCtrl = Get.find<AuthCtrl>();

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Text.rich(
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '👋 Bienvenido ',
              style: Get.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  '${authCtrl.currentUser?.txAtributo?.txNombre}'.toUpperCase(),
              style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: Get.theme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
