import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

enum TypeMetodoPago { debitoInmediato, sencillo }

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
      'type': TypeMetodoPago.debitoInmediato
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

      await claimClientData();

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

      debugPrint('data: ${jsonEncode(data)}');
      if (typePago == TypeMetodoPago.debitoInmediato &&
          coClavePagoController.text.isEmpty) {
        await Http().http(showLoading: true).then((value) => value.post(
            '${dotenv.env['URL_API_SERVICIO']}$urlClavePago',
            data: data));
      } else {
        await Http().http(showLoading: true).then((value) =>
            value.post('${dotenv.env['URL_API_SERVICIO']}$url', data: data));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<dynamic> claimClavePago() async {
    await Get.dialog(AlertDialog(
      content: Column(
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
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Get.back();
              checkout(TypeMetodoPago.debitoInmediato);
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    ));
  }

  Future<dynamic> claimClientData() async {
    final acctTp = await Helper().getAcctTp();

    return await Get.dialog(
      AlertDialog(
        content: SizedBox(
          height: Get.height * 0.5,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 10.0),
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
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: idClienteController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  idClienteController.text = value.toUpperCase();
                },
                decoration: InputDecoration(
                  labelText: 'Identidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
