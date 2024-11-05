import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageInfoAlert extends StatelessWidget {
  const PackageInfoAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: const Text('Actualizar app'),
      content:
          const Text('Hay una nueva versión disponible. ¿Desea actualizar?'),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.error,
                ),
                onPressed: () => Get.back(),
                child: Text(
                  'Cancelar',
                  style:
                      Get.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor,
                ),
                child: Text(
                  'Actualizar',
                  style:
                      Get.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  launchUrl(Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.bankingtechnologies.consulting.confiao'));
                  Get.back();
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
