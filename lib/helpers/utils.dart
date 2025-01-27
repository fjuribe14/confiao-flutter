import 'dart:math';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<List?> getAcctTp() async {
    final resultJson = await readJsonFromLocaly('assets/other/data_form'
        '.json');

    List? acctpTpJson = resultJson['acct_tp'];

    return acctpTpJson;
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
        getNumberFormat().format(val.toPrecision(2)),
        decimalSeparator: ',',
      );

  Future<String?> getToken() async {
    return await const FlutterSecureStorage()
        .read(key: StorageKeys.storageItemUserToken);
  }

  Future<String?> getRefreshToken() async {
    return await const FlutterSecureStorage()
        .read(key: StorageKeys.storageItemUserRefreshToken);
  }

  Future getTokenAud() async {
    final token = await getToken();
    JWT jwt = JWT.decode(token!);
    return jwt.payload['aud'];
  }

  Future getTokenSub() async {
    final token = await getToken();
    JWT jwt = JWT.decode(token!);
    return jwt.payload['sub'];
  }

  Future getUser() async {
    final token = await getToken();
    JWT jwt = JWT.decode(token!);
    return jwt.payload['user'];
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
    PackageInfo device = await DeviceInfoService().getAppInfo;
    return 'V${device.version}.${device.buildNumber}';
  }

  dateFormat({required DateTime dateTime, String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).format(dateTime);
  }

  FinanciamientoPreview previewFinanciamiento({
    required double montoFinanciamiento,
    required ModeloFinanciamiento modeloFinanciamiento,
  }) {
    int diasAnual = 365;

    int caDias = modeloFinanciamiento.caCuotas! *
        modeloFinanciamiento.nuDiasEntreCuotas!;

    double pcDiario =
        double.parse(modeloFinanciamiento.pcTasaInteres ?? '0.0') / diasAnual;

    double pcIntereses = (pcDiario * caDias).toPrecision(2);

    double moTotal =
        montoFinanciamiento + montoFinanciamiento * (pcIntereses / 100);

    final double moPcInicial = (moTotal *
            (double.parse(modeloFinanciamiento.pcInicial ?? '0.0')
                    .toPrecision(2) /
                100))
        .toPrecision(2);

    double moTotalPagar = (montoFinanciamiento - moPcInicial) +
        montoFinanciamiento * (pcIntereses / 100);

    return FinanciamientoPreview(
      caDias: caDias,
      moTotal: moTotal,
      pcDiario: pcDiario,
      pcIntereses: pcIntereses,
      moPcInicial: moPcInicial,
      moTotalPagar: moTotalPagar,
      cuotas: calcularCuotas(
        montoFinanciamiento: montoFinanciamiento,
        modeloFinanciamiento: modeloFinanciamiento,
      ),
    );
  }

  List<CuotaPreview> calcularCuotas({
    required double montoFinanciamiento,
    required ModeloFinanciamiento modeloFinanciamiento,
  }) {
    List<CuotaPreview> cuotas = [];
    int caCuotas = modeloFinanciamiento.caCuotas!;
    double pcTasaInteres =
        double.parse(modeloFinanciamiento.pcTasaInteres ?? '0.0');
    int nuDiasEntreCuotas = modeloFinanciamiento.nuDiasEntreCuotas!;
    double tasaDiaria = pcTasaInteres * nuDiasEntreCuotas / (360 * 100);
    double pcInicial = double.parse(modeloFinanciamiento.pcInicial ?? '0.0');

    montoFinanciamiento =
        montoFinanciamiento - montoFinanciamiento * (pcInicial / 100);

    for (var i = 0; i < caCuotas; i++) {
      final cuota = calcularAmortizacion(
        index: i,
        caCuotas: caCuotas,
        tasaDiaria: tasaDiaria,
        montoFinanciamiento: montoFinanciamiento,
        modeloFinanciamiento: modeloFinanciamiento,
      );

      cuotas.add(cuota);
    }

    return cuotas;
  }

  CuotaPreview calcularAmortizacion({
    required int index,
    required int caCuotas,
    required double tasaDiaria,
    required double montoFinanciamiento,
    required ModeloFinanciamiento modeloFinanciamiento,
  }) {
    double saldoInicio = montoFinanciamiento;
    double moTotalCuota =
        (saldoInicio * (tasaDiaria * pow(1 + tasaDiaria, caCuotas))) /
            (pow(1 + tasaDiaria, caCuotas) - 1);
    double interes = saldoInicio * tasaDiaria;
    double capital = moTotalCuota - interes;
    double saldoFinal = saldoInicio - capital;

    return CuotaPreview(
        nuCuota: index + 1,
        saldoInicio: saldoInicio,
        interes: interes,
        moTotalCuota: moTotalCuota,
        capital: capital,
        saldoFinal: saldoFinal,
        feCuota: Intl().date('dd-MM-yyyy').format(DateTime.now().add(Duration(
            days: ((index + 1) * modeloFinanciamiento.nuDiasEntreCuotas!)))));
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

FinanciamientoPreview financiamientoPreviewFromJson(String str) =>
    FinanciamientoPreview.fromJson(json.decode(str));

String financiamientoPreviewToJson(FinanciamientoPreview data) =>
    json.encode(data.toJson());

class FinanciamientoPreview {
  int? caDias;
  double? moTotal;
  double? pcDiario;
  double? pcIntereses;
  double? moPcInicial;
  double? moTotalPagar;
  List<CuotaPreview>? cuotas;

  FinanciamientoPreview({
    this.caDias,
    this.moTotal,
    this.pcDiario,
    this.pcIntereses,
    this.moPcInicial,
    this.moTotalPagar,
    this.cuotas,
  });

  factory FinanciamientoPreview.fromJson(Map<String, dynamic> json) =>
      FinanciamientoPreview(
        caDias: json["caDias"],
        moTotal: json["moTotal"]?.toDouble(),
        pcDiario: json["pcDiario"]?.toDouble(),
        pcIntereses: json["pcIntereses"]?.toDouble(),
        moPcInicial: json["moPcInicial"]?.toDouble(),
        moTotalPagar: json["moTotalPagar"]?.toDouble(),
        cuotas: json["cuotas"] == null
            ? []
            : List<CuotaPreview>.from(
                json["cuotas"]!.map((x) => CuotaPreview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "caDias": caDias,
        "moTotal": moTotal,
        "pcDiario": pcDiario,
        "pcIntereses": pcIntereses,
        "moPcInicial": moPcInicial,
        "moTotalPagar": moTotalPagar,
        "cuotas": cuotas == null
            ? []
            : List<dynamic>.from(cuotas!.map((x) => x.toJson())),
      };
}

class CuotaPreview {
  int? nuCuota;
  double? saldoInicio;
  double? interes;
  double? moTotalCuota;
  double? capital;
  double? saldoFinal;
  String? feCuota;

  CuotaPreview({
    this.nuCuota,
    this.saldoInicio,
    this.interes,
    this.moTotalCuota,
    this.capital,
    this.saldoFinal,
    this.feCuota,
  });

  factory CuotaPreview.fromJson(Map<String, dynamic> json) => CuotaPreview(
        nuCuota: json["nuCuota"],
        saldoInicio: json["saldoInicio"],
        interes: json["interes"]?.toDouble(),
        moTotalCuota: json["moTotalCuota"]?.toDouble(),
        capital: json["capital"]?.toDouble(),
        saldoFinal: json["saldoFinal"]?.toDouble(),
        feCuota: json["feCuota"],
      );

  Map<String, dynamic> toJson() => {
        "nuCuota": nuCuota,
        "saldoInicio": saldoInicio,
        "interes": interes,
        "moTotalCuota": moTotalCuota,
        "capital": capital,
        "saldoFinal": saldoFinal,
        "feCuota": feCuota,
      };
}
