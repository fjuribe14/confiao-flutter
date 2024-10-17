import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CuotaCtrl extends GetxController {
  String url = ApiUrl.apiCuota;
  RxBool loading = false.obs;
  RxList<Cuota> data = <Cuota>[].obs;

  // Obtenemos el mes actual
  int mesActual = DateTime.now().month;

  // Obtenemos el año actual
  int anioActual = DateTime.now().year;

  // Obtenemos el día actual
  int diaActual = DateTime.now().day;

  // Obtenemos el ultimo dia del mes
  late DateTime ultimoDiaMes;

  // Creamos un listado de días del mes
  List<DateTime> diasDelMes = <DateTime>[].obs;

  // Creamos un listado de nombres de días de la semana
  List<String> nombresDiasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  @override
  void onInit() async {
    ultimoDiaMes = DateTime(anioActual, mesActual + 1, 0);

    setUltimoDiaMes();
    await getData();
    // debugPrint(diasDelMes.toList().toString());
    // debugPrint(DateTime(anioActual, mesActual + 1, 0).toString());
    super.onInit();
  }

  setUltimoDiaMes() {
    for (int dia = diaActual; dia <= ultimoDiaMes.day; dia++) {
      diasDelMes.add(DateTime(anioActual, mesActual, dia));
    }
  }

  getData() async {
    try {
      loading.value = true;

      final response = await Http().http(showLoading: false).then((http) => http
          .get('${dotenv.env['URL_API_BASE']}$url',
              queryParameters: {'financiamiento.st_financiamiento': 'ACTIVO'}));

      for (var item in response.data['data']) {
        data.add(Cuota.fromJson(item));
        debugPrint(item.toString());
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }

  bool hasCuotaDia(DateTime fecha) {
    return data.any((item) => item.feCuota == fecha);
  }
}
