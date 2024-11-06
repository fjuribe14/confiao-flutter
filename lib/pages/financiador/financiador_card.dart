import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';

class FinanciadorCard extends StatelessWidget {
  const FinanciadorCard({super.key});

  @override
  Widget build(BuildContext context) {
    double tasa = 0.0;

    Get.put(FinanciadorCtrl());
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();

    if (comunesCtrl.tasas.isNotEmpty) {
      tasa = double.parse(comunesCtrl.tasas[0].moMonto!);
    }

    return GetBuilder<FinanciadorCtrl>(
      init: FinanciadorCtrl(),
      builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () {
              if (ctrl.loading.isTrue) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }

              if (ctrl.data.isEmpty) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Center(
                    child: Text('Lo sentimos, no hay financiadores aún.'),
                  ),
                );
              }

              final item = ctrl.data.first;

              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: SvgPicture.asset(
                            AssetsDir.logo,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Text(
                          item.nbFinanciador!,
                          style: Get.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    item.inAfiliado!
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${item.limiteCliente?.moDisponible}'))}',
                                textAlign: TextAlign.end,
                                style: Get.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              if (tasa > 0)
                                Text(
                                    'Bs. ${Helper().getAmountFormatCompletDefault(double.parse('${item.limiteCliente?.moDisponible}') * tasa)}',
                                    textAlign: TextAlign.end,
                                    style: Get.textTheme.titleSmall)
                            ],
                          )
                        : InkWell(
                            onTap: () async => await ctrl.cotizar(),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(
                                    colors: [
                                      Get.theme.primaryColor,
                                      Get.theme.colorScheme.secondary,
                                    ],
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Te damos la bienvenida a Confio',
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Get.theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Cotiza tu financiamiento dando clic aquí',
                                    style: Get.textTheme.titleSmall?.copyWith(
                                      color: Get.theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    if (item.inAfiliado!) const SizedBox(height: 10.0),
                    if (item.inAfiliado!)
                      LinearProgressIndicator(
                        minHeight: 10.0,
                        backgroundColor:
                            Get.theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20.0),
                        value: double.parse(
                                '${item.limiteCliente?.moDisponible}') /
                            double.parse('${item.limiteCliente?.moLimite}'),
                      ),
                    if (item.inAfiliado!) const SizedBox(height: 20.0),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
