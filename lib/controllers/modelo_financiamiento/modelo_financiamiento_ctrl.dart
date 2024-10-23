import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ModeloFinanciamientoCtrl extends GetxController {
  String url = ApiUrl.apiModeloFinanciamiento;

  RxBool loading = false.obs;
  ScrollController scrollController = ScrollController();
  RxList<ModeloFinanciamiento> data = <ModeloFinanciamiento>[].obs;

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
        'with': 'modelo_financiamiento'
      };

      final response = await Http().http(showLoading: false).then(
            (http) => http.get(
              '${dotenv.env['URL_API_BASE']}$url',
              queryParameters: queryParameters,
            ),
          );

      for (var item in response.data['data']) {
        data.add(ModeloFinanciamiento.fromJson(item));
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
