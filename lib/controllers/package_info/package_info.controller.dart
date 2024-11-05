import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/apiurl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    checkVersion();
  }

  Future<void> checkVersion() async {
    try {
      Dio dio = Dio();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final response = await dio.get(ApiUrl.uriVersion);
      final updateVersion = response.data['APP_VERSION'];
      final localVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

      debugPrint('updateVersion: $updateVersion localVersion: $localVersion');

      if (updateVersion != localVersion && Platform.isAndroid) {
        Get.dialog(const PackageInfoAlert());
      }

      return;
    } catch (e) {
      return debugPrint(e.toString());
    }
  }
}
