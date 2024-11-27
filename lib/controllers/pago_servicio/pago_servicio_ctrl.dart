import 'package:get/get.dart';
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
  RxBool loading = false.obs;
  RxDouble moTotal = 0.0.obs;
  RxDouble moSubTotal = 0.0.obs;
  Rx<Tienda> tienda = Tienda().obs;
  AuthCtrl authCtrl = Get.find<AuthCtrl>();
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
      'label': 'Débito Inmediato',
      'type': TypeMetodoPago.solicitudClave
    },
    {'selected': false, 'label': 'R4 Sencillo', 'type': TypeMetodoPago.sencillo}
  ].obs;

  get metodoPagoSelected => metodosPago[
      metodosPago.indexWhere((element) => element['selected'] == true)];

  checkout(TypeMetodoPago typePago) async {
    try {
      loading.value = true;
      final financiamiento = financiamientoCtrl.financiamiento.value;
      final cuotas =
          financiamientoCtrl.cuotasSelected.map((e) => e.idCuota).toList();

      late bool claimClavePagoResult = false;
      late bool verificationByClient = false;
      late bool claimClientDataResult = false;

      if (![TypeMetodoPago.debitoInmediato, TypeMetodoPago.sencillo]
          .contains(typePago)) {
        claimClientDataResult = await claimClientData(typePago);
      }

      final coIdentificacion =
          authCtrl.currentUser?.txAtributo['co_identificacion'];

      if (idClienteController.text.isEmpty) {
        idClienteController.text = coIdentificacion;
      }

      if (TypeMetodoPago.sencillo == typePago) {
        agtClienteController.text = '0169';
        schemaAcctClienteController.text = 'ALIS';
        acctClienteController.text = coIdentificacion;
      }

      final data = {
        "id_cuotas": cuotas,
        "co_producto": "050",
        "mo_monto": moTotal.value,
        "id_cliente": idClienteController.text,
        "nb_cliente": authCtrl.currentUser?.name,
        "agt_cliente": agtClienteController.text,
        "acct_cliente": acctClienteController.text,
        "co_clave_pago": coClavePagoController.text,
        "co_servicio": financiamiento.coIdentificacionEmpresa,
        "schema_acct_cliente": schemaAcctClienteController.text,
        "tx_referencia": financiamientoCtrl.cuotasSelected[0].idCuotaUuid,
        'schema_id_cliente':
            await Helper().getSchemeName(idClienteController.text),
        "co_sub_producto": TypeMetodoPago.sencillo == typePago ? "003" : "002",
        "tx_concepto":
            "Pago de #${financiamiento.idFinanciamiento} Cuotas ${cuotas.join(', ')}",
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

        verificationByClient = await getVerificationByClient();

        // debugPrint('verificationByClient: $verificationByClient');

        if (verificationByClient) {
          await Http().http(showLoading: true).then((value) =>
              value.post('${dotenv.env['URL_API_SERVICIO']}$url', data: data));

          AlertService().showSnackBar(
            title: 'Se ha enviado el pago',
            body:
                'Se le enviará una notificación con la respuesta de la operación.',
          );

          Get.offAndToNamed(AppRouteName.onboarding);
        }
      }
    } catch (e) {
      debugPrint('$e');

      AlertService().showSnackBar(
        title: 'Ha ocurrido un error',
        body: 'Intente nuevamente, por favor.',
      );

      Get.back(result: false);
    } finally {
      loading.value = false;
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
            InkWell(
              onTap: () => Get.back(result: true),
              child: Container(
                width: double.infinity,
                height: Get.height * 0.075,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Get.theme.primaryColor,
                      Get.theme.colorScheme.secondary,
                    ],
                    end: Alignment.topRight,
                    begin: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Enviar pago',
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
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
                    labelText: 'Número',
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
              InkWell(
                onTap: () => Get.back(result: true),
                child: Container(
                  width: double.infinity,
                  height: Get.height * 0.075,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Get.theme.primaryColor,
                        Get.theme.colorScheme.secondary,
                      ],
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Continuar',
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<bool> getVerificationByClient() async {
    final financiamiento = financiamientoCtrl.financiamiento.value;
    final cuotas =
        financiamientoCtrl.cuotasSelected.map((e) => e.idCuota).toList();

    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        actionsPadding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        title: Text(
          '¿ Seguro que desea realizar este pago ?',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Pagará el financiamiento #${financiamiento.idFinanciamiento} con (${cuotas.length}) cuotas.',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.back(result: false),
                  child: Container(
                    width: double.infinity,
                    height: Get.height * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Get.theme.primaryColor.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: InkWell(
                  onTap: () => Get.back(result: true),
                  child: Container(
                    width: double.infinity,
                    height: Get.height * 0.075,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Get.theme.primaryColor,
                          Get.theme.colorScheme.secondary,
                        ],
                        end: Alignment.topRight,
                        begin: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Continuar',
                        style: Get.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
