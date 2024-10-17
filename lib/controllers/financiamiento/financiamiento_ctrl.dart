import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinanciamientoCtrl extends GetxController {
  String url = ApiUrl.apiFinanciamiento;

  RxBool loading = false.obs;
  RxList<Cuota> cuotas = <Cuota>[].obs;
  RxList<Financiamiento> data = <Financiamiento>[].obs;

  // Obtenemos el ultimo dia del mes
  late DateTime ultimoDiaMes;
  // Obtenemos el día actual
  int diaActual = DateTime.now().day;
  // Obtenemos el mes actual
  int mesActual = DateTime.now().month;
  // Obtenemos el año actual
  int anioActual = DateTime.now().year;
  // Creamos un listado de días del mes
  List<DateTime> diasDelMes = <DateTime>[].obs;

  @override
  void onInit() async {
    _setUltimoDiaMes();
    _setDiasDelMes();
    //
    super.onInit();
    //
    await getData();
  }

  _setUltimoDiaMes() {
    ultimoDiaMes = DateTime(anioActual, mesActual + 1, 0);
  }

  _setDiasDelMes() {
    for (int dia = diaActual; dia <= ultimoDiaMes.day; dia++) {
      diasDelMes.add(DateTime(anioActual, mesActual, dia));
    }
  }

  hasCuotaDia(DateTime fecha) {
    return cuotas.any((item) => item.feCuota == fecha);
  }

  getData() async {
    try {
      loading.value = true;

      Map<String, dynamic>? queryParameters = {
        'with': 'cuotas',
        'st_financiamiento': 'ACEPTADO',
      };

      final response = await Http().http(showLoading: false).then((http) =>
          http.get('${dotenv.env['URL_API_BASE']}$url',
              queryParameters: queryParameters));

      for (var item in response.data['data']) {
        // Financiamiento
        final newFinanciamiento = Financiamiento.fromJson(item);

        // Cuotas
        for (var cuota in newFinanciamiento.cuotas!) {
          cuotas.add(cuota);
        }

        data.add(newFinanciamiento);
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
