import 'package:confiao/helpers/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';
import 'package:shimmer/shimmer.dart';

class FacturaCard extends StatelessWidget {
  final String? idFactura;
  final String? fecha;
  const FacturaCard({super.key, required this.idFactura, required this.fecha});

  @override
  Widget build(BuildContext context) {
    FacturaCtrl ctrl = Get.put(FacturaCtrl());

    if (idFactura == null) return Container();

    return Obx(() {
      final item = ctrl.factura.value;

      if (item.nuFactura == null) {
        ctrl.getFacturaById(idFactura);
      }

      if (ctrl.loading.value) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Shimmer.fromColors(
            baseColor: Get.theme.colorScheme.surfaceContainer,
            highlightColor: Get.theme.colorScheme.surfaceContainerHigh,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        );
      }

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Get.theme.colorScheme.primary.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Factura #${item.idFactura.toString().padLeft(4, '0')}',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                '$fecha',
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Get.theme.colorScheme.primary,
                ),
              )
            ]),
            if (item.detalles != null) const SizedBox(height: 10),
            if (item.detalles != null)
              Table(
                textDirection: TextDirection.ltr,
                textBaseline: TextBaseline.alphabetic,
                defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1)
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Producto',
                            textAlign: TextAlign.start,
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Cantidad',
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Precio',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...item.detalles!.map(
                    (e) => TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: Get.theme.colorScheme.secondaryFixedDim,
                          ),
                        ),
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              '${e.nbProducto}'.toCapitalized(),
                              textAlign: TextAlign.start,
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'x ${e.caProducto.toString().padLeft(2, '0')}',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Bs. ${Helper().getAmountFormatCompletDefault(
                                double.parse('${e.moTotal}'),
                              )}',
                              textAlign: TextAlign.end,
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: Get.theme.colorScheme.secondaryFixedDim,
                        ),
                      ),
                    ),
                    children: const [
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      SizedBox(height: 10)
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Total',
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Bs. ${Helper().getAmountFormatCompletDefault(
                              double.parse('${item.moTotal}'),
                            )}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
          ],
        ),
      );
    });
  }
}
