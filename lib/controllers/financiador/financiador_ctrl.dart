import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinanciadorCtrl extends GetxController {
  String url = ApiUrl.apiFinanciador;

  RxBool loading = false.obs;
  RxList<Financiador> data = <Financiador>[].obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    try {
      loading.value = true;

      data.clear();

      Map<String, String> queryParameters = {
        'st_financiador': 'ACTIVO',
        'append': 'in_afiliado,limite_cliente',
      };

      final response = await Http().http(showLoading: false).then((value) =>
          value.get('${dotenv.env['URL_API_BASE']}$url',
              queryParameters: queryParameters));

      for (var item in response.data['data']) {
        final newData = Financiador.fromJson(item);

        data.add(newData);
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }

  Future cotizar() async {
    try {
      loading.value = true;

      await Http().http(showLoading: true).then((value) => value.post(
          '${dotenv.env['URL_API_BASE']}$url/solicitar',
          data: {'id_financiador': 1}));

      await getData();
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
