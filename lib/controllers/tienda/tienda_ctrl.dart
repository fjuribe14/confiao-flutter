import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TiendaCtrl extends GetxController {
  String url = ApiUrl.apiTienda;

  RxBool loading = false.obs;
  RxList<Tienda> data = <Tienda>[].obs;
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
        'with': 'empresa_modelo_financiamiento'
      };

      final response = await Http().http(showLoading: false).then(
            (http) => http.get(
              '${dotenv.env['URL_API_MARKET']}$url',
              queryParameters: queryParameters,
            ),
          );

      for (var item in response.data['data']) {
        data.add(Tienda.fromJson(item));
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
