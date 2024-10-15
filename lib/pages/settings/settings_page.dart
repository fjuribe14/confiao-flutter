import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:confiao/controllers/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: Get.theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<SettingsCtrl>(
          init: SettingsCtrl(),
          builder: (ctrl) {
            return Obx(
              () => SettingsList(
                brightness: Brightness.light,
                sections: [
                  CustomSettingsSection(
                    child: SettingsTile.navigation(
                      onPressed: (context) {},
                      title: const Text('Perfil'),
                      leading: const Icon(Icons.account_circle_outlined),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),

                  SettingsSection(
                    title: const Text('Seguridad'),
                    tiles: <SettingsTile>[
                      SettingsTile.switchTile(
                        onToggle: (value) async {
                          await ctrl.toggleBiometricPermission(value);
                        },
                        initialValue: ctrl.biometricPermission.value,
                        title: const Text('Biométrico'),
                        leading: const Icon(Icons.fingerprint_outlined),
                        enabled: ctrl.canBiometric.value,
                        description: Text(
                          ctrl.biometricPermission.value ? 'On' : 'Off',
                        ),
                      ),
                    ],
                  ),
                  // SettingsSection(
                  //   title: const Text('Permisos'),
                  //   tiles: <SettingsTile>[
                  //     SettingsTile.switchTile(
                  //       onToggle: (value) {
                  //         ctrl.tooglePushNotificationPermission();
                  //         // ctrl.pushNotificationPermission.value = value;
                  //         // ctrl.pushNotificationPermission.refresh();
                  //       },
                  //       title: const Text('Push Notification'),
                  //       leading: const Icon(Icons.notifications),
                  //       initialValue: ctrl.pushNotificationPermission.value,
                  //       description: Text(
                  //         ctrl.pushNotificationPermission.value ? 'On' : 'Off',
                  //       ),
                  //     ),
                  //     SettingsTile.switchTile(
                  //       onToggle: (value) {
                  //         ctrl.storagePermission.value = value;
                  //         ctrl.storagePermission.refresh();
                  //       },
                  //       title: const Text('Storage'),
                  //       leading: const Icon(Icons.save),
                  //       initialValue: ctrl.storagePermission.value,
                  //       description: Text(
                  //         ctrl.storagePermission.value ? 'On' : 'Off',
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  CustomSettingsSection(
                    child: SettingsTile.navigation(
                      onPressed: (context) {
                        // Get.find<GlobalController>(tag: 'global-main')
                        //     .endSessionUser(withRedirect: true);
                      },
                      title: const Text('Cerrar Sesión'),
                      leading: const Icon(Icons.exit_to_app_outlined),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

// ListView(
      //   children: [
      //     // buildItemMenu(
      //     //   title: 'profile'.tr,
      //     //   // subtitle: 'Muestra la información de mi cuenta.',
      //     //   iconStart: Icons.accessibility_outlined,
      //     //   onPress: () => Get.toNamed(AppRouteName.profile),
      //     // ),
      //     // dividerMenu(),

      //     // dividerMenu(),
      //     // buildItemMenu(
      //     //   title: 'Términos y condiciones',
      //     //   // subtitle: 'Lee los términos y condiciones.',
      //     //   iconStart: Icons.policy_outlined,
      //     //   onPress: () => Get.to(
      //     //     () => PrivacyPolicePage(
      //     //       title: 'Terms_conditions'.tr,
      //     //       iconTitle: SvgPicture.asset(
      //     //         AssetsDir.iconTermCond,
      //     //         height: 20,
      //     //       ),
      //     //       docDir: AssetsDir.vposTerminos,
      //     //     ),
      //     //   ),
      //     // ),
      //     // dividerMenu(),
      //     // buildItemMenu(
      //     //   title: 'Políticas de privacidad',
      //     //   // subtitle: 'Lee las políticas de privacidad.',
      //     //   iconStart: Icons.policy_outlined,
      //     //   onPress: () => Get.to(
      //     //     () => PrivacyPolicePage(
      //     //       title: 'privacy_policy'.tr,
      //     //       iconTitle: SvgPicture.asset(
      //     //         AssetsDir.iconTermCond,
      //     //         height: 20,
      //     //       ),
      //     //       docDir: AssetsDir.vposPolicies,
      //     //     ),
      //     //   ),
      //     // ),
      //     // dividerMenu(),
      //     // buildItemMenu(
      //     //   title: 'Dispositivos',
      //     //   iconStart: Icons.device_unknown,
      //     //   onPress: () => Get.toNamed(AppRouteName.devices),
      //     // ),
      //     dividerMenu(),
      //     buildItemMenu(
      //       title: 'Permisos',
      //       iconStart: Icons.shield_outlined,
      //       onPress: () => Get.toNamed(AppRouteName.permissionDevice),
      //     ),
      //     dividerMenu(),
      //     Obx(
      //       () => ListTile(
      //         title: const Text('Modo oscuro'),
      //         // subtitle: const Text('Establece el tema en app.'),
      //         leading: Icon(
      //           globalController.isDarkMode.value
      //               ? Icons.light_mode_outlined
      //               : Icons.dark_mode_outlined,
      //         ),
      //         trailing: CupertinoSwitch(
      //           onChanged: (val) async {
      //             await globalController.toDarkMode();
      //           },
      //           value: globalController.isDarkMode.value,
      //         ),
      //       ),
      //     ),
      //     dividerMenu(),
      //     buildItemMenu(
      //       title: 'exit'.tr,
      //       // subtitle: 'Cierra la sesión activa en app.',
      //       iconStart: Icons.exit_to_app,
      //       colorIcon: Get.theme.colorScheme.primary,
      //       colorText: Get.theme.colorScheme.primary,
      //       onPress: () => globalController.endSessionUser(),
      //     ),
      //     dividerMenu(),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 5.0, right: 15.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           const HelpAppWidget(),
      //           Text(
      //             '${globalController.appVersion}',
      //             style: const TextStyle(fontSize: 12.0),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),