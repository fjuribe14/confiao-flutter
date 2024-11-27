import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';

class AmortizacionCuotas extends StatelessWidget {
  const AmortizacionCuotas({
    super.key,
    required this.tasa,
    required this.cuotas,
  });

  final double tasa;
  final List<Cuota> cuotas;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cuotas.isNotEmpty)
          Text(
            'Amortizaciones'.toCapitalized(),
            textAlign: TextAlign.center,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        if (cuotas.isNotEmpty) const SizedBox(height: 10.0),
        if (cuotas.isNotEmpty)
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Capital'.toCapitalized(),
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Cuota'.toCapitalized(),
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Interés'.toCapitalized(),
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Pagar'.toCapitalized(),
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              ...cuotas.map((cuota) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moInicioCuota ?? '0'))}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moInicioCuota ?? "0") * tasa)}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moCuota ?? '0'))}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: Get.theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moCuota ?? '0') * tasa)}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodySmall?.copyWith(
                                // color: Get.theme.colorScheme.primary,
                                ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moInteresCuota ?? '0'))}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: Get.theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moInteresCuota ?? '0') * tasa)}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodySmall?.copyWith(
                                // color: Get.theme.colorScheme.primary,
                                ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '- \$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moTotalCuota ?? '0'))}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Get.theme.colorScheme.error,
                            ),
                          ),
                          Text(
                            '- Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moTotalCuota ?? '0') * tasa)}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodySmall?.copyWith(
                              color: Get.theme.colorScheme.error,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
      ],
    );
  }
}
