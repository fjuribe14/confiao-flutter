import 'package:confiao/controllers/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordOne extends StatelessWidget {
  const ResetPasswordOne({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl ctrl = Get.find<AuthCtrl>();

    return SingleChildScrollView(
      clipBehavior: Clip.hardEdge,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Get.theme.colorScheme.primary.withOpacity(0.5),
                      Get.theme.colorScheme.primary.withOpacity(0.2),
                    ])),
            child: SvgPicture.asset(
              AssetsDir.authResetPassword1,
              height: Responsive.width(80),
              width: Responsive.width(80),
            ),
          ),
          const SizedBox(height: 20),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Para cambiar tu contraseña te enviaremos una clave al correo ',
                  style: Get.textTheme.bodyLarge,
                ),
                TextSpan(
                  text: '${ctrl.currentUser?.email}',
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      ', para que puedas seguir disfrutando de la aplicación.',
                  style: Get.textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
