import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupFour extends StatelessWidget {
  const SetupFour({super.key});

  @override
  Widget build(BuildContext context) {
    SetupCtrl ctrl = Get.find<SetupCtrl>();

    return Obx(() {
      return SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            // SvgPicture.asset(
            //   AssetsDir.setup2,
            //   height: Responsive.width(60),
            // ),
            Text('Necesitamos saber que estas de acuerdo.',
                textAlign: TextAlign.left,
                style: Get.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0),
            Text(
              'Tomate tu tiempo para leer los términos y condiciones. No te preocupes, puedes cambiar tus preferencias en cualquier momento.',
              textAlign: TextAlign.left,
              style: Get.textTheme.bodyLarge,
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://confiao.sencillo.com.ve/assets/docs/terminos.html',
                    ),
                  );
                },
                child: const Text('Ver términos y condiciones')),
            const SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://confiao.sencillo.com.ve/assets/docs/privacidad.html',
                    ),
                  );
                },
                child: const Text('Ver políticas de privacidad')),
            const SizedBox(height: 30.0),
            CheckboxListTile(
              value: ctrl.selectedTerminos.value,
              title: const Text('Acepto los términos y condiciones.'),
              subtitle: const Text('He leido los términos y condiciones.'),
              onChanged: (value) {
                ctrl.selectedTerminos.value = value ?? false;
              },
            ),
            const SizedBox(height: 10.0),
            CheckboxListTile(
              value: ctrl.selectedPrivacidad.value,
              title: const Text('Acepto la política de privacidad.'),
              subtitle: const Text('He leido las políticas de privacidad.'),
              onChanged: (value) {
                ctrl.selectedPrivacidad.value = value ?? false;
              },
            ),
            // selectedPermisos
            // selectedTerminos
          ],
        ),
      );
    });
  }
}
