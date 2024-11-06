import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class FinanciamientoDetail extends StatelessWidget {
  const FinanciamientoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();
    final double tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');

    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
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
                    if (item.cuotas!.isNotEmpty)
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
                                    // Get.back();
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
                                                'Ref ${cuota.txReferencia!.substring(cuota.txReferencia!.length - 8, cuota.txReferencia!.length)}',
                                                style: Get.textTheme.titleMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Fecha ${cuota.fePagoCuota}',
                                                style: Get.textTheme.titleMedium
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
                              Intl().date('dd-MM-yyyy').format(cuota.feCuota!),
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
                      )
                  ],
                ),
              ),
            ),
            Container(
              height: 100.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
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
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
              ),
            ),
          ],
        );
      },
    );
  }
}
