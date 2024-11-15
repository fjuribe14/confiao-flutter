import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class FinanciamientoDetail extends StatelessWidget {
  const FinanciamientoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final uuid = const Uuid().v4().toString();
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();
    final double tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');
    // ctrl.pagoservicioCtrl.schemaAcctClienteController

    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
        return Obx(() {
          Financiamiento item = ctrl.financiamiento.value;

          return Column(
            children: [
              Container(
                height: 5,
                width: Get.width / 3,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  clipBehavior: Clip.hardEdge,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const TiendaCard(),
                      if (((item.cuotas?.isNotEmpty ?? false) &&
                          item.inCredito != true))
                        ...item.cuotas!.map(
                          (cuota) {
                            final isPagada = cuota.stCuota == 'PAGADA';

                            return ListTile(
                              leading: isPagada
                                  ? SizedBox(
                                      width: 50,
                                      child: Icon(
                                        ctrl.getIconCuota(cuota),
                                        color: ctrl.getColorCuota(cuota),
                                      ),
                                    )
                                  : Checkbox(
                                      value: cuota.selected,
                                      onChanged: (value) {
                                        cuota.selected = value!;
                                        ctrl.update();
                                      },
                                    ),
                              onTap: !isPagada
                                  ? () {
                                      cuota.selected = !cuota.selected!;
                                      ctrl.update();
                                    }
                                  : () {
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text(
                                            'Pagada',
                                            style: Get.textTheme.titleLarge,
                                          ),
                                          content: SizedBox(
                                            height: 100.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Ref #${cuota.txReferencia != null ? cuota.txReferencia!.substring(cuota.txReferencia!.length - 8, cuota.txReferencia!.length) : '00000000'}',
                                                  style: Get
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Fecha ${Intl().date('dd-MM-yyyy').format(cuota.fePagoCuota!)}',
                                                  style: Get
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                              title: Text(
                                '${cuota.stCuota}'.toCapitalized(),
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ctrl.getColorCuota(cuota),
                                ),
                              ),
                              subtitle: Text(
                                Intl()
                                    .date('dd-MM-yyyy')
                                    .format(cuota.feCuota!),
                                style: Get.textTheme.bodyMedium,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moTotalCuota!))}',
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moTotalCuota!) * tasa)}',
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      if (!((item.cuotas?.isNotEmpty ?? false) &&
                          item.inCredito != true))
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                isDense: true,
                                hint: const Text('Seleccione Banco'),
                                items: ctrl
                                    .pagoservicioCtrl.comunesCtrl.participantes
                                    .map((e) {
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
                                    ctrl.pagoservicioCtrl.agtClienteController
                                            .text =
                                        '${value.coParticipante}'
                                            .padLeft(4, '0');
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
                              TextField(
                                controller:
                                    ctrl.pagoservicioCtrl.acctClienteController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  ctrl.pagoservicioCtrl.acctClienteController
                                      .text = value.toUpperCase();
                                },
                                decoration: InputDecoration(
                                  labelText: 'Télefono',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: '0424, 0416, 0412, etc.',
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller:
                                    ctrl.pagoservicioCtrl.idClienteController,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  ctrl.pagoservicioCtrl.idClienteController
                                      .text = value.toUpperCase();
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
                              Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:
                                        Get.theme.colorScheme.surfaceContainer,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Monto a solicitar'.toCapitalized(),
                                        style: Get.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                      Text(
                                        '\$ ${Helper().getAmountFormatCompletDefault(double.parse(item.moTotalFinanc ?? '0'))}',
                                        textAlign: TextAlign.center,
                                        style:
                                            Get.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(item.moTotalFinanc ?? '0') * tasa)}',
                                        textAlign: TextAlign.center,
                                        style: Get.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100.0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: item.inCredito != true
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ ${Helper().getAmountFormatCompletDefault(ctrl.moTotalCuotasSelected)}',
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Bs. ${Helper().getAmountFormatCompletDefault(ctrl.moTotalCuotasSelected * tasa)}',
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: Get.textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: !ctrl.hasCuotasSelectedAndPendientes
                                  ? null
                                  : () => ctrl.checkout(
                                        tasa: tasa,
                                        newFinanciamiento: item,
                                      ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                backgroundColor: Get.theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                'Pagar',
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: ctrl.loading.value
                                  ? null
                                  : () => ctrl.withdraw(
                                        tasa: tasa,
                                        txReferencia: uuid,
                                        newFinanciamiento: item,
                                      ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                backgroundColor: Get.theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                'Solicitar',
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          );
        });
      },
    );
  }
}
