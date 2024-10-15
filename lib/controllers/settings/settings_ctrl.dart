import 'package:get/get.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsCtrl extends GetxController {
  Rx<bool> canBiometric = false.obs;
  Rx<bool> storagePermission = false.obs;
  Rx<bool> biometricPermission = false.obs;
  Rx<bool> localAuthPermission = false.obs;
  Rx<bool> pushNotificationPermission = false.obs;

  @override
  void onInit() async {
    super.onInit();

    canBiometric.value = await LocalAuth().checkBiometric();
    biometricPermission.value = await LocalAuth().getBiometricPermission();
  }

  togglePushNotificationPermission() async {
    if (pushNotificationPermission.value) {
      pushNotificationPermission.value = false;
    } else {
      await Permission.notification.request();
      pushNotificationPermission.value = true;
    }
  }

  toggleBiometricPermission(bool value) async {
    AuthCtrl authCtrl = Get.put(AuthCtrl());

    final claim = await authCtrl.claimPassword(state: value);

    authCtrl.passwordController.clear();

    if (claim == true) {
      await LocalAuth().setBiometricPermission(value);
      biometricPermission.value = value;
      biometricPermission.refresh();
    }
  }
}
