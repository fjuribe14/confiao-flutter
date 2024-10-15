import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:confiao/helpers/index.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> _checkBiometric() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      return await _authenticateWithBiometric();
    } else {
      Get.snackbar('Error', 'No se pudo autenticar con el dispositivo');
      return false;
    }
  }

  Future<bool> _authenticateWithBiometric() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        // Get.snackbar('Autenticación', 'Autenticación exitosa');
      } else {
        Get.snackbar('Autenticación', 'Autenticación fallida');
      }

      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Add handling of no hardware here.
        Get.snackbar('Error', 'No se pudo autenticar con el dispositivo');
      } else if (e.code == auth_error.notEnrolled) {
        // ...
        Get.snackbar('Error', 'No se pudo autenticar con el dispositivo');
      } else {
        // ...
        Get.snackbar('Error', 'No se pudo autenticar con el dispositivo');
      }

      return false;
    }
  }

  Future<bool> authenticate() async {
    return await _checkBiometric();
  }

  Future<bool> checkBiometric() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<void> setBiometricPermission(bool value) async {
    await secureStorage.write(
      key: StorageKeys.storageItemPermissionsBiometry,
      value: value.toString(),
    );
  }

  Future<bool> getBiometricPermission() async {
    final String? value = await secureStorage.read(
        key: StorageKeys.storageItemPermissionsBiometry);
    return value == 'true';
  }
}
