import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum TypeMetodoPago { solicitudClave, debitoInmediato, sencillo }

class PagoServicioCtrl extends GetxController {
  String url = ApiUrl.apiPagarPersonal;
  String urlClavePago = ApiUrl.apiClavePago;

  RxDouble tasa = 0.0.obs;
  RxDouble moTotal = 0.0.obs;
  RxDouble moSubTotal = 0.0.obs;
  String uuid = const Uuid().v4();
  Rx<Tienda> tienda = Tienda().obs;
  ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();
  FinanciamientoCtrl financiamientoCtrl = Get.find<FinanciamientoCtrl>();

  final idClienteController = TextEditingController();
  final agtClienteController = TextEditingController();
  final acctClienteController = TextEditingController();
  final coClavePagoController = TextEditingController();
  final schemaAcctClienteController = TextEditingController();

  List<Map<String, dynamic>> metodosPago = [
    {
      'selected': false,
      'label': 'Débito C2P',
      'type': TypeMetodoPago.solicitudClave
    },
    {'selected': false, 'label': 'R4 Sencillo', 'type': TypeMetodoPago.sencillo}
  ].obs;

  get metodoPagoSelected => metodosPago[
      metodosPago.indexWhere((element) => element['selected'] == true)];

  checkout(TypeMetodoPago typePago) async {
    try {
      final financiamiento = financiamientoCtrl.financiamiento.value;
      final cuotas =
          financiamientoCtrl.cuotasSelected.map((e) => e.idCuota).toList();

      late bool claimClavePagoResult = false;
      late bool claimClientDataResult = false;

      if (typePago != TypeMetodoPago.debitoInmediato) {
        claimClientDataResult = await claimClientData(typePago);
      }

      final data = {
        "id_cuotas": cuotas,
        "co_producto": "050",
        "tx_referencia": uuid,
        "co_sub_producto": "002",
        "mo_monto": moTotal.value,
        "nb_cliente": tienda.value.nbEmpresa,
        "id_cliente": idClienteController.text,
        "agt_cliente": agtClienteController.text,
        "acct_cliente": acctClienteController.text,
        "co_clave_pago": coClavePagoController.text,
        "co_servicio": financiamiento.coIdentificacionEmpresa,
        "schema_acct_cliente": schemaAcctClienteController.text,
        "schema_id_cliente":
            await Helper().getSchemeName(idClienteController.text),
      };

      // debugPrint('idClienteController: ${idClienteController.text}');
      // debugPrint('agtClienteController: ${agtClienteController.text}');
      // debugPrint('acctClienteController: ${acctClienteController.text}');
      // debugPrint('coClavePagoController: ${coClavePagoController.text}');

      // debugPrint('claimClientDataResult: $claimClientDataResult');
      // debugPrint(
      //     'Validation: ${typePago == TypeMetodoPago.solicitudClave && claimClientDataResult}');
      // debugPrint('data: ${jsonEncode(data)}');

      if (typePago == TypeMetodoPago.solicitudClave && claimClientDataResult) {
        await Http().http(showLoading: true).then((value) => value.post(
            '${dotenv.env['URL_API_SERVICIO']}$urlClavePago',
            data: data));

        claimClavePagoResult = await claimClavePago();

        // debugPrint('claimClavePagoResult: $claimClavePagoResult');

        if (claimClavePagoResult) {
          await checkout(TypeMetodoPago.debitoInmediato);
        }
      } else {
        // debugPrint('Pagar: ${jsonEncode(data)}');

        await Http().http(showLoading: true).then((value) =>
            value.post('${dotenv.env['URL_API_SERVICIO']}$url', data: data));

        AlertService().showSnackBar(
          title: 'Se ha enviado el pago',
          body:
              'Se le enviará una notificación con la respuesta de la operación',
        );

        Get.offAndToNamed(AppRouteName.home);
      }
    } catch (e) {
      debugPrint('$e');

      AlertService().showSnackBar(
        title: 'Ha ocurrido un error',
        body: 'Intente nuevamente, por favor.',
      );

      Get.back(result: false);
    } finally {
      idClienteController.clear();
      agtClienteController.clear();
      acctClienteController.clear();
      coClavePagoController.clear();
      schemaAcctClienteController.clear();
    }
  }

  Future<dynamic> claimClavePago() async {
    return await Get.dialog(AlertDialog(
      content: SizedBox(
        width: Get.width * 0.8,
        height: Get.height * 0.3,
        child: Column(
          children: [
            TextField(
              controller: coClavePagoController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                coClavePagoController.text = value.toUpperCase();
              },
              decoration: InputDecoration(
                labelText: 'Clave de pago',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Ingrese clave de pago',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    ));
  }

  Future<dynamic> claimClientData(TypeMetodoPago typePago) async {
    final acctTp = await Helper().getAcctTp();

    if (typePago == TypeMetodoPago.sencillo) {
      agtClienteController.text = '0169';
      schemaAcctClienteController.text = 'ALIS';
    }

    return await Get.dialog(
      AlertDialog(
        content: SizedBox(
          height: Get.height * 0.5,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (typePago != TypeMetodoPago.sencillo)
                DropdownButtonFormField(
                  isDense: true,
                  hint: const Text('Seleccione Banco'),
                  items: comunesCtrl.participantes.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        '${'${e.coParticipante}'.padLeft(4, '0')} - ${e.txAlias}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      agtClienteController.text =
                          '${value.coParticipante}'.padLeft(4, '0');
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Banco',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              if (typePago != TypeMetodoPago.sencillo)
                const SizedBox(height: 10.0),
              if (typePago != TypeMetodoPago.sencillo)
                DropdownButtonFormField(
                  isDense: true,
                  hint: const Text('Tipo de cuenta'),
                  items: acctTp?.map((e) {
                    return DropdownMenuItem(
                      value: e['acct_type'],
                      child: Text(
                        '${e['acct_label']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    schemaAcctClienteController.text = '$value';
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipo de cuenta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              if (typePago != TypeMetodoPago.sencillo)
                const SizedBox(height: 10.0),
              if (typePago != TypeMetodoPago.sencillo)
                TextField(
                  controller: acctClienteController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    acctClienteController.text = value.toUpperCase();
                  },
                  decoration: InputDecoration(
                    labelText: 'Cuenta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: '042412345678, 0169123456..., etc.',
                  ),
                ),
              if (typePago != TypeMetodoPago.sencillo)
                const SizedBox(height: 10.0),
              TextField(
                controller: idClienteController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  idClienteController.text = value.toUpperCase();
                  if (typePago == TypeMetodoPago.sencillo) {
                    acctClienteController.text = value.toUpperCase();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Identidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'V12345678, E12345678, etc.',
                ),
              ),
              const SizedBox(height: 10.0),
              if (typePago == TypeMetodoPago.sencillo)
                TextField(
                  controller: coClavePagoController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    coClavePagoController.text = value.toUpperCase();
                  },
                  decoration: InputDecoration(
                    labelText: 'Clave de pago',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
