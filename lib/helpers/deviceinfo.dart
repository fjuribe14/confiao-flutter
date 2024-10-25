import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:confiao/helpers/index.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  // final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<dynamic> get getDeviceInfo async {
    var deviceData = <String, dynamic>{};

    try {
      // if (kIsWeb) {
      //   deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      // } else {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
      // } else if (Platform.isLinux) {
      //   deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
      // } else if (Platform.isMacOS) {
      //   deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
      // } else if (Platform.isWindows) {
      //   deviceData =
      //       _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
      // }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'error:': 'Failed to get platform version.'
      };
    }
    return deviceData;
  }

  Future<dynamic> get getAppInfo async {
    PackageInfo packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
    );

    try {
      packageInfo = await PackageInfo.fromPlatform();
    } on PlatformException {
      if (kDebugMode) {
        print({'error:': 'Failed to get platform version.'});
      }
    }
    return packageInfo;
  }

  Future<Map<String, dynamic>> getMetaDataDevice(String action,
      {Map<String, dynamic>? additionalData,
      String? txUsuario,
      String? tokenFirebase}) async {
    dynamic location;

    try {
      location = await Location().getCurrentPosition();
    } catch (e) {
      location = {"error": e.toString()};
    }

    var deviceInfo = await getDeviceInfo;
    PackageInfo appInfo = await getAppInfo;
    String uniqueDeviceId = '';

    if (Platform.isIOS) {
      uniqueDeviceId =
          '${deviceInfo["name"]}:${deviceInfo["identifierForVendor"]}';
    } else if (Platform.isAndroid) {
      uniqueDeviceId = '${deviceInfo["model"]}:${deviceInfo["id"]}';
    }

    var jsonData = {
      'nb_servicio': dotenv.env['APP_ALIAS'] ?? 'CONFIAO',
      'co_dispositivo': uniqueDeviceId,
      'st_dispositivo':
          ![null, '', 'null'].contains(tokenFirebase) ? 'ACTIVO' : 'INACTIVO',
      "tx_token_firebase": tokenFirebase,
      'tx_data': {
        'app_info': {
          'app_name': appInfo.appName,
          'package_name': appInfo.packageName,
          'version': appInfo.version,
          'build_number': appInfo.buildNumber,
          'build_signure': appInfo.buildSignature,
        },
        'device_info': deviceInfo,
        'additional_data': additionalData ?? {},
      },
      'tx_ubicacion': location,
      'tx_accion': action,
      'tx_usuario': txUsuario ?? '',
      // 'client_id': Environments.clientId,
    };

    return jsonData;
  }

  Future saveMetaDataApi(String action,
      {bool registerDevicePush = false,
      Map<String, dynamic>? additionalData,
      String? txUsuario}) async {
    var jsonData = await getMetaDataDevice(action,
        txUsuario: txUsuario, additionalData: additionalData);

    /// todo:pendiente
    // if (registerDevicePush) {
    //   PushNotificationController pushNotificationController;
    //   try {
    //     pushNotificationController = Get.find<PushNotificationController>();
    //     debugPrint('find PushNotificationController');
    //   } catch (e) {
    //     debugPrint('fail find PushNotificationController saveMetaDataApi');
    //     pushNotificationController = Get.put(PushNotificationController());
    //   }
    //
    //   /// await request permission notifications
    //   pushNotificationController.registerDevice(jsonData);
    // }

    final http = Http().http(showLoading: false);

    return await http.then(
      (value) => value.post(
        ApiUrl.apiRestEndPointRegisterDeviceRecent,
        data: jsonData,
      ),
    );
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'id': build.id,
      'model': build.model,
      'manufacturer': build.manufacturer,
      'product': build.product,
      'brand': build.brand,
      'device': build.device,
      'serialNumber': build.data['serialNumber'],
      'version': {
        'baseOS': build.version.baseOS,
        'codename': build.version.codename,
        'incremental': build.version.incremental,
        'previewSdkInt': build.version.previewSdkInt,
        'sdkInt': build.version.sdkInt,
        'release': build.version.release,
        'securityPatch': build.version.securityPatch,
      },
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      //'systemFeatures': build.systemFeatures,
      // 'displaySizeInches':
      // ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      // 'displayWidthPixels': build.displayMetrics.widthPx,
      // 'displayWidthInches': build.displayMetrics.widthInches,
      // 'displayHeightPixels': build.displayMetrics.heightPx,
      // 'displayHeightInches': build.displayMetrics.heightInches,
      // 'displayXDpi': build.displayMetrics.xDpi,
      // 'displayYDpi': build.displayMetrics.yDpi,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'model': data.model,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
