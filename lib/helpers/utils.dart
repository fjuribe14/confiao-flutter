import 'dart:math';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:confiao/helpers/index.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Helper {
  final _random = Random();

  var datetimeService = DateTimes();

  /// Generates a positive random integer uniformly distributed on the range
  /// from [min], inclusive, to [max], exclusive, long [long].
  String getRandomNumber({int min = 0, int max = 9, int length = 1}) {
    List<int> rands = [];
    for (var i = 0; i < length; i++) {
      rands.add((min + _random.nextInt(max - min)));
    }
    return rands.join('');
  }

  //
  //string to base 64
  //
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  String base64Decode(String text) => stringToBase64.decode(text);

  Future<String> getSchemeTpLabel(dynamic type) async {
    final resultJson = await readJsonFromLocaly('assets/other/data_form'
        '.json');

    List? schemeNameJson = resultJson['scheme_name'];
    return schemeNameJson?.firstWhere(
            (element) => element['scheme_type'] == type)?['scheme_label'] ??
        '';
  }

  Future<String> getAcctTpLabel(String type) async {
    final resultJson = await readJsonFromLocaly('assets/other/data_form'
        '.json');

    List? acctpTpJson = resultJson['acct_tp'];

    return acctpTpJson?.firstWhere(
            (acctp) => acctp['acct_type'] == type)?['acct_label'] ??
        '';
  }

  String getBankName(participantsJson, String param) {
    dynamic name;
    participantsJson.forEach((result) {
      if (result['co_participante'] == param) {
        name = result['tx_alias'] ?? '';
        return;
      }
    });
    return name ?? '';
  }

  Future readJsonFromLocaly(String dir) async {
    final String response = await rootBundle.loadString(dir);
    final resp = await json.decode(response);
    return resp;
  }

  String getMsgIdValue(
          String agentCd, String centroDistribucion, String consecutivoMsg) =>
      agentCd +
      centroDistribucion +
      datetimeService.nowInFormatyyyyMMddHHmmss +
      consecutivoMsg;

  String getCreDtTm() => datetimeService.nowInFormatXML;

  String getCreDtTmJson() => datetimeService.nowInFormatJSON;

  String getEndToEndId(String agentCd, String consecutivoMsg) =>
      agentCd + datetimeService.nowInFormatyyyyMMddHHmmss + consecutivoMsg;

  NumberFormat getNumberFormat() => NumberFormat.decimalPattern('es-VE');

  getAmountFormatComplet(String amount, {String decimalSeparator = '.'}) {
    var amountSplit = amount.split(decimalSeparator);

    if (amountSplit.length == 1) {
      amountSplit.addAll(['0']);
    }

    int number = amountSplit[1].isNotEmpty ? amountSplit[1].length : 0;
    do {
      if (amountSplit[1].length < 2) {
        amountSplit[1] = '${amountSplit[1]}0';
      }
      number++;
    } while (number < 2);
    return amountSplit.join(decimalSeparator);
  }

  String getAmountFormatCompletDefault(double val) => getAmountFormatComplet(
        getNumberFormat().format(
          val,
        ),
        decimalSeparator: ',',
      );

  Future<String?> getToken() async {
    return await const FlutterSecureStorage()
        .read(key: StorageKeys.storageItemUserToken);
  }

  /// parse jwt token and return data
  Map<String, dynamic> tryParseJwt(String token) {
    // function content here...
    if (token.isEmpty) return {};
    final parts = token.split('.');
    if (parts.length != 3) {
      return {};
    }

    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return {};
    }
    return payloadMap;
  }

  Future<String> getSchemeName(String id) async {
    final resultJson = await readJsonFromLocaly('assets/other/data_form'
        '.json');

    List? value = resultJson['cod_scheme_name'];

    return value
            ?.firstWhere((acctp) => acctp['cod'] == id[0])?['scheme_type'] ??
        '';
  }

  bool isEsLang() {
    final result = ['es_'].contains(Get.deviceLocale.toString());
    return result;
  }

  getLogoAppByTheme() {
    return Get.isDarkMode ? AssetsDir.logoLight : AssetsDir.logo;
  }

  double getDoubleFromString(String val) {
    return double.tryParse(val.contains(',')
            ? val.replaceAll('.', '').replaceAll(',', '.')
            : val) ??
        0.0;
  }

  Future<String> getAppBuildVersion() async {
    printInfo(info: 'getAppBuildVersion');
    PackageInfo device = await DeviceInfoService().getAppInfo;
    return 'V${device.version}.${device.buildNumber}';
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
