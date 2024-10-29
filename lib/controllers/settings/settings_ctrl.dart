import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsCtrl extends GetxController {
  Rx<bool> canBiometric = false.obs;
  Rx<bool> storagePermission = false.obs;
  Rx<bool> biometricPermission = false.obs;
  Rx<bool> localAuthPermission = false.obs;
  Rx<bool> pushNotificationPermission = false.obs;
  NotificationCtrl notificationCtrl = Get.put(NotificationCtrl());
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void onInit() async {
    super.onInit();

    canBiometric.value = await LocalAuth().checkBiometric();
    pushNotificationPermission.value = await hasNotificationPermission();
    biometricPermission.value = await LocalAuth().getBiometricPermission();
  }

  Future<bool> hasNotificationPermission() async {
    await notificationCtrl.requestPermissions();

    final String? value = await secureStorage.read(
        key: StorageKeys.storageItemPermissionsNotifications);

    return value == 'true';
  }

  Future<void> togglePushNotificationPermission({bool? value = false}) async {
    try {
      final validation = value ?? pushNotificationPermission.value;

      final PermissionStatus status = await Permission.notification.request();

      if (validation &&
          ![
            PermissionStatus.granted,
            PermissionStatus.provisional,
          ].contains(status)) {
        await notificationCtrl.requestPermissions();
        pushNotificationPermission.value = false;
        pushNotificationPermission.refresh();
      } else {
        await notificationCtrl.removePermissions();
        pushNotificationPermission.value = true;
        pushNotificationPermission.refresh();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  toggleBiometricPermission(bool value) async {
    AuthCtrl authCtrl = Get.find<AuthCtrl>();

    final claim = await authCtrl.claimPassword(state: value);

    authCtrl.passwordController.clear();

    if (claim == true) {
      await LocalAuth().setBiometricPermission(value);
      biometricPermission.value = value;
      biometricPermission.refresh();
      authCtrl.update();
    }
  }
}
