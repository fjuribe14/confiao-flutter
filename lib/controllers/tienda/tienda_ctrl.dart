import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TiendaCtrl extends GetxController {
  String url = ApiUrl.apiTienda;
  String urlTiendas = ApiUrl.apiTiendas;

  RxBool loading = false.obs;
  Rx<Tienda> tienda = Tienda().obs;
  RxList<Tienda> data = <Tienda>[].obs;
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    try {
      loading.value = true;

      data.clear();

      Map<String, dynamic>? queryParameters = {
        'append': 'credito',
        'st_empresa': 'ACTIVA',
        'with': 'empresa_modelo_financiamiento',
        'tx_identificacion_cliente':
            '${authCtrl.currentUser?.txAtributo?.coIdentificacion}',
      };

      final response = await Http().http(showLoading: false).then(
            (http) => http.get(
              '${dotenv.env['URL_API_MARKET']}$urlTiendas',
              queryParameters: queryParameters,
            ),
          );

      for (var item in response.data['data']) {
        data.add(Tienda.fromJson(item));
      }
      log(data.length.toString());
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }

  getDataBy({Map<String, dynamic>? queryParameters}) async {
    try {
      tienda.value = Tienda();

      queryParameters ??= {};

      queryParameters.addAll({
        'append': 'credito',
        'st_empresa': 'ACTIVA',
        'bo_financiamiento': true,
        'with': 'empresa_modelo_financiamiento',
        'tx_identificacion_cliente':
            '${authCtrl.currentUser?.txAtributo?.coIdentificacion}',
      });

      final response = await Http().http(showLoading: true).then((value) {
        return value.get(
          '${dotenv.env['URL_API_MARKET']}$url',
          queryParameters: queryParameters,
        );
      });

      if (response.data['data'] != null) {
        tienda.value = Tienda.fromJson(response.data['data'][0]);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
