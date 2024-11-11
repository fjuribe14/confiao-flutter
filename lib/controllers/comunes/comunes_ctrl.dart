import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ComunesCtrl extends GetxController {
  String? urlTasa = ApiUrl.apiTasaValor;
  String? urlParticipantes = ApiUrl.apiParticipantes;

  RxBool loading = false.obs;
  RxList<TasaValor> tasas = <TasaValor>[].obs;
  RxList<Participante> participantes = <Participante>[].obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  Future<void> getData() async {
    await getTasaValor();
    await getParticipantes();
  }

  Future<void> getTasaValor() async {
    try {
      loading.value = true;

      tasas.clear();

      Map<String, dynamic>? queryParameters = {
        'per_page': '1',
        'co_tasa': 'USD',
        'order_by': 'id_tasa:desc',
        'fecha_valor_lte': Intl().date('yyyy-MM-dd').format(DateTime.now()),
      };

      final response = await Http().http(showLoading: false).then(
            (http) => http.get(
              '${dotenv.env['URL_API_COMUNES']}$urlTasa',
              queryParameters: queryParameters,
            ),
          );

      for (var item in response.data['data']) {
        tasas.add(TasaValor.fromJson(item));
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> getParticipantes() async {
    try {
      loading.value = true;

      participantes.clear();

      Map<String, dynamic>? queryParameters = {
        'per_page': '0',
        'st_participante': 'ACTIVO',
        'order_by': 'tx_alias:asc',
      };

      final response = await Http().http(showLoading: false).then(
            (http) => http.get(
              '${dotenv.env['URL_API_COMUNES']}$urlParticipantes',
              queryParameters: queryParameters,
            ),
          );

      for (var item in response.data['data']) {
        participantes.add(Participante.fromJson(item));
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
