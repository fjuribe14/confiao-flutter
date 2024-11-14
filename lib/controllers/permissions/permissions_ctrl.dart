import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PermissionsCtrl extends GetxController {
  NotificationCtrl notificationCtrl = Get.put(NotificationCtrl());
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void onInit() async {
    await requestPermissionLocation();
    await requestPermissionNotifications();
    super.onInit();
  }

  requestPermissionLocation() async {
    try {
      final storageItemPermissionsLocation = await secureStorage.read(
          key: StorageKeys.storageItemPermissionsLocation);

      if (storageItemPermissionsLocation == 'true') {
        return;
      } else {
        final status = await Permission.location.request();

        await secureStorage.write(
          key: StorageKeys.storageItemPermissionsLocation,
          value: status.isGranted.toString(),
        );
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  requestPermissionNotifications() async {
    try {
      await notificationCtrl.requestPermissions();
    } catch (e) {
      debugPrint('$e');
    }
  }
}
