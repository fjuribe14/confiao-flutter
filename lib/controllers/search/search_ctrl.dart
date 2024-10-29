import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchCtrl extends GetxController {
  String url = '/api/v1/public/buscar';

  late Tienda item;
  RxBool loading = false.obs;
  RxBool isCredito = false.obs;
  TiendaCtrl tiendaCtrl = Get.find<TiendaCtrl>();
  final queryController = TextEditingController();
  Rx<SearchProducto> producto = SearchProducto().obs;
  List<SearchProducto> data = <SearchProducto>[].obs;

  @override
  void onInit() async {
    item = tiendaCtrl.tienda.value;

    await getData();
    super.onInit();
  }

  Future getData() async {
    try {
      loading.value = true;

      data.clear();

      Map<String, dynamic>? queryParameters = {};

      queryParameters.addAllIf(isCredito.isTrue, {'nb_categoria': 'Crédito'});

      queryParameters
          .addAllIf(isCredito.isFalse, {'nb_categoria_not': 'Crédito'});

      queryParameters
          .addAllIf(item.idEmpresa != null, {'id_empresa': item.idEmpresa});

      queryParameters.addAllIf(
          queryController.text.isNotEmpty, {'q': queryController.text});

      final response = await Http().http(showLoading: false).then(
            (http) => http.get(
              '${dotenv.env['URL_API_MARKET']}$url',
              queryParameters: queryParameters,
            ),
          );

      for (var item in response.data['data']) {
        data.add(SearchProducto.fromJson(item));
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
