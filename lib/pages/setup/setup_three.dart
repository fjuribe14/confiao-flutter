import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SetupThree extends StatelessWidget {
  const SetupThree({super.key});

  @override
  Widget build(BuildContext context) {
    SetupCtrl setupCtrl = Get.find<SetupCtrl>();

    return SingleChildScrollView(
      clipBehavior: Clip.hardEdge,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            AssetsDir.setup3,
            height: Responsive.width(60),
          ),
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
                  text: setupCtrl.emailController.text,
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
            borderColor: Get.theme.primaryColor,
            focusedBorderColor: Get.theme.primaryColor,
            textStyle: TextStyle(fontSize: Responsive.width(5.0)),
            onSubmit: (String verificationCode) {
              setupCtrl.next();
            },
          ),
          const SizedBox(height: 30.0),
          ElevatedButton.icon(
            onPressed: null,
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
