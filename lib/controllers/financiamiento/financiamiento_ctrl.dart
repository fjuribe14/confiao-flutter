import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FinanciamientoCtrl extends GetxController {
  String url = ApiUrl.apiFinanciamiento;
  String urlCheckout = ApiUrl.apiCheckout;
  String urlPublic = ApiUrl.apiFinanciamientoPublic;

  RxBool loading = false.obs;
  RxInt statusSelected = 0.obs;
  DateTime hoy = DateTime.now();
  RxBool showHistorial = false.obs;
  RxList<Cuota> cuotas = <Cuota>[].obs;
  List<DateTime> dias = <DateTime>[].obs;
  RxList<Financiamiento> data = <Financiamiento>[].obs;
  ScrollController scrollController = ScrollController();
  List<String> status = <String>['ACEPTADO', 'PENDIENTE'];
  Rx<Financiamiento> financiamiento = Financiamiento().obs;
  RxList<Financiamiento> dataHistorial = <Financiamiento>[].obs;

  late PagoServicioCtrl pagoservicioCtrl;

  @override
  void onInit() async {
    //
    initializeDateFormatting('es_ES');
    //
    _setDiasDelMes();
    //
    super.onInit();
    //
    await getData();
    //
    pagoservicioCtrl = PagoServicioCtrl();
  }

  get totalCuotas => cuotas.length;

  List<Cuota> get cuotasPendientes =>
      cuotas.where((item) => item.stCuota != 'PAGADA').toList();

  List<Cuota> get cuotasSelected =>
      cuotas.where((item) => item.selected!).toList();

  bool get hasCuotasSelectedAndPendientes =>
      cuotas.any((item) => item.stCuota != 'PAGADA' && item.selected!);

  double get moCuotasSelected => hasCuotasSelectedAndPendientes
      ? cuotas
          .where((item) => item.stCuota != 'PAGADA' && item.selected!)
          .map((item) => double.parse('${item.moCuota}'))
          .reduce((a, b) => a + b)
      : 0.0;

  double get moTotalCuotasSelected => hasCuotasSelectedAndPendientes
      ? cuotas
          .where((item) => item.stCuota != 'PAGADA' && item.selected!)
          .map((item) => double.parse('${item.moTotalCuota}'))
          .reduce((a, b) => a + b)
      : 0.0;

  IconData getIconCuota(Cuota item) {
    switch (item.stCuota) {
      case 'VENCIDA':
        return Icons.close;
      case 'PAGADA':
        return Icons.check;
      default:
        return Icons.hourglass_empty;
    }
  }

  Color getColorCuota(Cuota item) {
    switch (item.stCuota) {
      case 'VENCIDA':
        return Get.theme.colorScheme.error;
      case 'PAGADA':
        return Get.theme.colorScheme.primary;
      default:
        return Get.theme.colorScheme.onSurface.withOpacity(0.3);
    }
  }

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
              DateFormat('dd-MM-yyyy').format(fecha) &&
          ['PENDIENTE', 'VENCIDA'].contains(item.stCuota);
    });
  }

  getData() async {
    try {
      loading.value = true;

      data.clear();
      cuotas.clear();
      dataHistorial.clear();

      AuthCtrl authCtrl = Get.find<AuthCtrl>();

      Map<String, dynamic>? queryParameters = {
        'per_page': 0,
        'with': 'cuotas',
        'order_by': 'id_financiamiento:desc',
        'st_financiamiento': status[statusSelected.value],
        'tx_identificacion_cliente':
            authCtrl.currentUser?.txAtributo['co_identificacion'],
      };

      final response = await Http().http(showLoading: false).then((http) =>
          http.get('${dotenv.env['URL_API_BASE']}$urlPublic/consultar',
              queryParameters: queryParameters));

      for (var item in response.data['data']) {
        // Financiamiento
        final newFinanciamiento = Financiamiento.fromJson(item);

        // Cuotas
        for (var cuota in newFinanciamiento.cuotas!) {
          cuotas.add(cuota);
        }

        if (newFinanciamiento.hasCuotasPendientes == true) {
          data.add(newFinanciamiento);
        } else {
          dataHistorial.add(newFinanciamiento);
        }
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }

  crearFinanciamiento({
    required int idEmpresa,
    required String nbEmpresa,
    required double moPrestamo,
    required int idModeloFinanciamiento,
    required String coIdentificacionEmpresa,
    required List<SearchProducto> productos,
  }) async {
    try {
      loading.value = true;

      final user = await Helper().getUser();
      final sub = await Helper().getTokenSub();
      final inFinancia = productos.first.inFinancia;

      Map<String, dynamic> dataCheckout = {
        "id_usuario": sub,
        "id_empresa": idEmpresa,
        "nb_empresa": nbEmpresa,
        "mo_prestamo": moPrestamo,
        "id_modelo_financiamiento": idModeloFinanciamiento,
        "co_identificacion_empresa": coIdentificacionEmpresa,
        "productos": productos
            .map((item) => {
                  "id_producto": item.idProducto,
                  "ca_producto": item.caSelected,
                  "id_sucursal": item.idSucursal,
                })
            .toList(),
      };

      final response = await Http().http(showLoading: true).then(
            (http) => http.post(
              '${dotenv.env['URL_API_MARKET']}$urlCheckout',
              data: dataCheckout,
            ),
          );

      Map<String, dynamic> dataFinanciamiento = {
        "id_conectado": sub,
        'in_credito': inFinancia,
        "mo_prestamo": moPrestamo,
        "nu_documento": response.data['id_factura'],
        "id_modelo_financiamiento": idModeloFinanciamiento,
        "co_identificacion_empresa": coIdentificacionEmpresa,
        "tx_identificacion_cliente":
            '${user['tx_atributo']['co_identificacion']}',
      };

      await Http().http(showLoading: true).then(
            (http) => http.post(
              '${dotenv.env['URL_API_BASE']}$urlPublic/crear',
              data: dataFinanciamiento,
            ),
          );

      AlertService().showSnackBar(
        title: 'Felicidades 🎉',
        body: 'Se ha creado el financiamiento',
      );

      if (inFinancia == true) {
        await Get.offAndToNamed(
          AppRouteName.financiamientoList,
          arguments: {'status': 1},
        );
        await getData();
      } else {
        Get.offAndToNamed(AppRouteName.onboarding);
      }
    } catch (e) {
      debugPrint('$e');
      AlertService().showSnackBar(
        title: 'Error',
        body: 'Por favor intenta nuevamente, más tarde',
      );
    } finally {
      loading.value = false;
    }
  }

  checkout({
    required double tasa,
    required Financiamiento newFinanciamiento,
  }) async {
    try {
      loading.value = true;

      TiendaCtrl tiendaCtrl = Get.find<TiendaCtrl>();
      PagoServicioCtrl pagoServicioCtrl = Get.put(PagoServicioCtrl());

      pagoServicioCtrl.tasa.value = tasa;
      financiamiento.value = newFinanciamiento;
      pagoServicioCtrl.tienda.value = tiendaCtrl.tienda.value;
      pagoServicioCtrl.moSubTotal.value = moCuotasSelected * tasa;
      pagoServicioCtrl.moTotal.value = moTotalCuotasSelected * tasa;

      Get.toNamed(AppRouteName.checkout);
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
    }
  }

  withdraw({
    required double tasa,
    required String txReferencia,
    required Financiamiento newFinanciamiento,
  }) async {
    try {
      loading.value = true;

      pagoservicioCtrl.schemaAcctClienteController.text = 'CELE';

      await Http().http(showLoading: true).then(
            (http) async => http.post(
                '${dotenv.env['URL_API_SERVICIO']}${ApiUrl.apiCobrarCredito}',
                data: {
                  "tx_referencia": txReferencia,
                  "id_cliente": pagoservicioCtrl.idClienteController.text,
                  "co_servicio": newFinanciamiento.coIdentificacionEmpresa,
                  "nb_cliente": pagoservicioCtrl.authCtrl.currentUser?.name,
                  "agt_cliente": pagoservicioCtrl.agtClienteController.text,
                  "acct_cliente": pagoservicioCtrl.acctClienteController.text,
                  "id_financiamiento": '${newFinanciamiento.idFinanciamiento}',
                  "mo_monto":
                      double.parse(newFinanciamiento.moPrestamo ?? '0') * tasa,
                  'schema_id_cliente': await Helper()
                      .getSchemeName(pagoservicioCtrl.idClienteController.text),
                  "schema_acct_cliente":
                      pagoservicioCtrl.schemaAcctClienteController.text,
                  "tx_concepto":
                      "Solicitud de crédito del financiamiento #${newFinanciamiento.idFinanciamiento}",
                }),
          );

      Get.back();
      Get.offAndToNamed(AppRouteName.onboarding);
      AlertService().showSnackBar(
          title: 'Felicidades 🎉',
          body: 'Se ha enviado la solicitud, esto puede tardar unos minutos.');
    } catch (e) {
      debugPrint('$e');
    } finally {
      loading.value = false;
      pagoservicioCtrl.idClienteController.clear();
      pagoservicioCtrl.agtClienteController.clear();
      pagoservicioCtrl.acctClienteController.clear();
      pagoservicioCtrl.schemaAcctClienteController.clear();
    }
  }
}
