import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ResetPasswordTwo extends StatelessWidget {
  const ResetPasswordTwo({super.key});

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
                  Get.theme.colorScheme.primary.withValues(alpha: 0.5),
                  Get.theme.colorScheme.primary.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: SvgPicture.asset(
              AssetsDir.authResetPassword2,
              height: Responsive.width(80),
              width: Responsive.width(80),
            ),
          ),
          const SizedBox(height: 20.0),
          Text('Te hemos enviado un correo',
              textAlign: TextAlign.center,
              style: Get.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20.0),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Por favor ingresa al correo ',
                  style: Get.textTheme.bodyLarge,
                ),
                TextSpan(
                  text: '${ctrl.currentUser?.email}',
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' te hemos enviado un código de validación.',
                  style: Get.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          OtpTextField(
            borderWidth: 4.0,
            numberOfFields: 6,
            showFieldAsBox: true,
            keyboardType: TextInputType.number,
            borderColor: Get.theme.primaryColor,
            focusedBorderColor: Get.theme.primaryColor,
            textStyle: TextStyle(fontSize: Responsive.width(5.0)),
            onSubmit: (String verificationCode) {
              ctrl.resetPasswordCodeController.text =
                  verificationCode.substring(0, 6);
              ctrl.nextResetPassword();
            },
          ),
          const SizedBox(height: 30.0),
          ElevatedButton.icon(
            onPressed: () {
              ctrl.resetPasswordStepOne();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reenviar código'),
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
