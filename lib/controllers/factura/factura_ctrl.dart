import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FacturaCtrl extends GetxController {
  String url = ApiUrl.apiFactura;

  RxBool loading = false.obs;
  Rx<Factura> factura = Factura().obs;
  RxList<Factura> data = <Factura>[].obs;

  @override
  dispose() {
    factura.value = Factura();
    super.dispose();
  }

  Future<void> getFacturaById(id) async {
    try {
      loading.value = true;

      var response = await Http().http(showLoading: false).then((http) => http
          .get('${dotenv.env['URL_API_MARKET']}$url/$id',
              queryParameters: {'with': 'detalles'}));

      factura.value = Factura.fromJson(response.data);
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
