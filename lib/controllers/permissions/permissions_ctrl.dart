import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PermissionsCtrl extends GetxController {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void onInit() async {
    await requestPermissionLocation();
    super.onInit();
  }

  requestPermissionLocation() async {
    try {
      final storageItemPermissionsLocation = await secureStorage.read(
          key: StorageKeys.storageItemPermissionsLocation);

      debugPrint(
          'storageItemPermissionsLocation $storageItemPermissionsLocation');

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
      final storageItemPermissionsNotifications = await secureStorage.read(
          key: StorageKeys.storageItemPermissionsNotifications);

      debugPrint(
          'storageItemPermissionsNotifications $storageItemPermissionsNotifications');

      if (storageItemPermissionsNotifications == 'true') {
        return;
      } else {
        final status = await Permission.notification.request();
        await secureStorage.write(
          key: StorageKeys.storageItemPermissionsNotifications,
          value: status.isGranted.toString(),
        );
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
