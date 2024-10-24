import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:confiao/controllers/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl authCtrl = Get.find<AuthCtrl>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.onPrimary,
        title: Text(
          'Configuración',
          style: Get.theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text(
              '${authCtrl.appVersion}',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<SettingsCtrl>(
          init: SettingsCtrl(),
          builder: (ctrl) {
            return Obx(
              () => SettingsList(
                brightness: Brightness.light,
                lightTheme: SettingsThemeData(
                  settingsListBackground: Get.theme.scaffoldBackgroundColor,
                ),
                sections: [
                  CustomSettingsSection(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Get.theme.colorScheme.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 24.0,
                            child: Text(
                              '${authCtrl.currentUser?.name?[0]}',
                              style: Get.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.primaryColor),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${authCtrl.currentUser?.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Get.theme.colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  '${authCtrl.currentUser?.email}',
                                  style: Get.textTheme.titleMedium?.copyWith(
                                    color: Get.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Text('👋', style: Get.textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ),
                  CustomSettingsSection(
                    child: SettingsTile.navigation(
                      onPressed: (context) {
                        Get.toNamed(AppRouteName.authResetPassword);
                      },
                      title: const Text('Cambiar contraseña'),
                      leading: const Icon(Icons.key_rounded),
                    ),
                  ),
                  CustomSettingsSection(
                    child: SettingsTile.navigation(
                      onPressed: (context) {
                        AuthCtrl().logout();
                      },
                      title: const Text('Cerrar Sesión'),
                      leading: const Icon(Icons.exit_to_app_outlined),
                    ),
                  ),
                  SettingsSection(
                    title: Text(
                      'Seguridad',
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                    tiles: <SettingsTile>[
                      SettingsTile.switchTile(
                        onToggle: (value) async =>
                            await ctrl.toggleBiometricPermission(value),
                        initialValue: ctrl.biometricPermission.value,
                        title: const Text('Biométrico'),
                        leading: const Icon(Icons.fingerprint_outlined),
                        enabled: ctrl.canBiometric.value,
                        description: Text(
                          ctrl.biometricPermission.value
                              ? 'Activo'
                              : 'Desactivado',
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Text(
                      'Permisos',
                      style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                    tiles: <SettingsTile>[
                      SettingsTile.switchTile(
                        onToggle: (value) async {
                          await ctrl.togglePushNotificationPermission(
                            value: value,
                          );
                        },
                        title: const Text('Notificaciones'),
                        leading: const Icon(Icons.notifications),
                        initialValue: ctrl.pushNotificationPermission.value,
                        description: Text(
                          ctrl.pushNotificationPermission.value
                              ? 'Activo'
                              : 'Desactivado',
                        ),
                      ),
                    ],
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
