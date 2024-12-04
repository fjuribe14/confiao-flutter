import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:carousel_slider/carousel_controller.dart';

class FinanciadorCtrl extends GetxController {
  String url = ApiUrl.apiFinanciador;

  RxInt index = 0.obs;
  RxBool loading = false.obs;
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
  RxList<Financiador> data = <Financiador>[].obs;
  final carouselSliderController = CarouselSliderController();

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
        'order_by': 'id_financiador:asc',
        'append': 'in_afiliado,limite_cliente',
        'tx_identificacion_cliente':
            '${authCtrl.currentUser?.txAtributo?.coIdentificacion}',
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

  Future cotizar(Financiador item) async {
    try {
      loading.value = true;

      await Http().http(showLoading: true).then((value) =>
          value.post('${dotenv.env['URL_API_BASE']}$url/solicitar', data: {
            'id_financiador': item.idFinanciador,
            'tx_identificacion_cliente':
                '${authCtrl.currentUser?.txAtributo?.coIdentificacion}',
          }));

      await getData();
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
