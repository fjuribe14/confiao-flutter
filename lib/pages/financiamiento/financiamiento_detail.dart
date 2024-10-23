import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class FinanciamientoDetail extends StatelessWidget {
  const FinanciamientoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
        Financiamiento item = Get.arguments;

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
                    if (item.cuotas!.isNotEmpty)
                      ...item.cuotas!.map(
                        (cuota) {
                          final isPagada = cuota.stCuota != 'PENDIENTE';

                          return ListTile(
                            enabled: !isPagada,
                            leading: isPagada
                                ? SizedBox(
                                    width: 50,
                                    child: Icon(
                                      Icons.check,
                                      color: Get.theme.colorScheme.primary,
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
                                : null,
                            title: Text(
                              '${cuota.stCuota}'.toCapitalized(),
                              style: Get.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
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
                                  '\$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moCuota!))}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moCuota!) * 39.8)}',
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
                          '\$ ${Helper().getAmountFormatCompletDefault(ctrl.moCuotasSelected)}',
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Bs. ${Helper().getAmountFormatCompletDefault(ctrl.moCuotasSelected * 39.8)}',
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
                      onPressed:
                          !ctrl.hasCuotasSelectedAndPendientes ? null : () {},
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
