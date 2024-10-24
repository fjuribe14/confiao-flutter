import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinanciamientoCtrl extends GetxController {
  String url = ApiUrl.apiFinanciamiento;

  RxBool loading = false.obs;
  RxInt statusSelected = 0.obs;
  DateTime hoy = DateTime.now();
  RxList<Cuota> cuotas = <Cuota>[].obs;
  List<DateTime> dias = <DateTime>[].obs;
  RxList<Financiamiento> data = <Financiamiento>[].obs;
  ScrollController scrollController = ScrollController();
  List<String> status = <String>['ACEPTADO', 'INACTIVO', 'PENDIENTE'];

  @override
  void onInit() async {
    // Inicializa los datos de configuración regional para el español
    initializeDateFormatting('es_ES');
    //
    _setDiasDelMes();
    //
    super.onInit();
    //
    await getData();
  }

  get totalCuotas => cuotas.length;

  List<Cuota> get cuotasPendientes =>
      cuotas.where((item) => item.stCuota == 'PENDIENTE').toList();

  List<Cuota> get cuotasSelected =>
      cuotas.where((item) => item.selected!).toList();

  bool get hasCuotasSelectedAndPendientes =>
      cuotas.any((item) => item.stCuota == 'PENDIENTE' && item.selected!);

  double get moCuotasSelected => hasCuotasSelectedAndPendientes
      ? cuotas
          .where((item) => item.stCuota == 'PENDIENTE' && item.selected!)
          .map((item) => double.parse('${item.moCuota}'))
          .reduce((a, b) => a + b)
      : 0.0;

  _setDiasDelMes() {
    //
    dias.clear();
    //
    for (int i = 0; i < 15; i++) {
      dias.add(DateTime.now().add(Duration(days: i)));
    }
  }

  isToday(DateTime date) {
    return date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year;
  }

  hasCuotaDia(DateTime fecha) {
    return cuotas.any((item) {
      return DateFormat('dd-MM-yyyy').format(item.feCuota!) ==
          DateFormat('dd-MM-yyyy').format(fecha);
    });
  }

  getData() async {
    try {
      loading.value = true;

      data.clear();
      cuotas.clear();

      Map<String, dynamic>? queryParameters = {
        'with': 'cuotas',
        'st_financiamiento': status[statusSelected.value],
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
        //
        data.add(newFinanciamiento);
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }
}
