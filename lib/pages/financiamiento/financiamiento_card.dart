import 'package:confiao/helpers/index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';

class FinanciamientoCard extends StatelessWidget {
  const FinanciamientoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
        return Obx(() {
          if (ctrl.loading.isTrue) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade300,
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

          if (ctrl.data.isEmpty) {
            return Container();
          }

          return Container(
            color: Get.theme.colorScheme.surfaceContainerLowest,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '⭐ Adelanta y gana',
                          style: Get.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '(${ctrl.cuotasPendientes.length}) Cuotas pendientes',
                          style: Get.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.toNamed(AppRouteName.financiamientoList);
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.all(0.0),
                        backgroundColor: Colors.transparent,
                      ),
                      iconAlignment: IconAlignment.end,
                      icon: Icon(
                        Icons.arrow_forward,
                        size: Get.textTheme.titleSmall?.fontSize,
                      ),
                      label: Text(
                        'Ver todos',
                        style: Get.textTheme.titleSmall?.copyWith(
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRouteName.financiamientoList);
                  },
                  child: SizedBox(
                    height: 80.0,
                    width: double.infinity,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.dias.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      itemBuilder: (context, index) {
                        final date = ctrl.dias[index];
                        final cuotaDia = ctrl.hasCuotaDia(date);

                        return Container(
                          width: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color:
                                  Get.theme.colorScheme.surfaceContainerHighest,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: cuotaDia
                                ? Get.theme.primaryColor
                                : ctrl.isToday(date)
                                    ? Get.theme.colorScheme
                                        .surfaceContainerHighest
                                    : Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${date.day}',
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: cuotaDia
                                      ? Get.theme.colorScheme.onPrimary
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                Intl()
                                    .date('EEE', 'es_ES')
                                    .format(date)
                                    .toUpperCase(),
                                style: Get.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: cuotaDia
                                      ? Get.theme.colorScheme.onPrimary
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
