import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchCtrl extends GetxController {
  String url = '/api/v1/public/buscar';
  final queryController = TextEditingController();
  List<SearchProducto> data = <SearchProducto>[].obs;

  @override
  void onInit() async {
    await getProductos();
    super.onInit();
  }

  Future getProductos() async {
    Map<String, dynamic>? queryParameters = {};

    debugPrint(queryController.text);

    if (queryController.text.isNotEmpty) {
      queryParameters = {'q': queryController.text};
    }

    final response = await Http().http(showLoading: false).then(
          (http) => http.get(
            '${dotenv.env['URL_API_MARKET']}$url',
            queryParameters: queryParameters,
          ),
        );

    for (var item in response.data['data']) {
      data.add(SearchProducto.fromJson(item));
    }
  }
}
