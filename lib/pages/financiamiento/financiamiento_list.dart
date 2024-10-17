import 'package:confiao/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class FinanciamientoList extends StatelessWidget {
  const FinanciamientoList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
        return Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (ctrl.loading.isTrue) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              );
            }

            if (ctrl.data.isEmpty) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: ctrl.diasDelMes.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10.0),
              itemBuilder: (context, index) {
                final date = ctrl.diasDelMes[index];
                final cuotaDia = ctrl.hasCuotaDia(date);

                return Container(
                  width: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Get.theme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                    color:
                        cuotaDia ? Get.theme.primaryColor : Colors.transparent,
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${date.day}',
                          style: Get.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: cuotaDia
                                ? Get.theme.colorScheme.onPrimary
                                : null,
                          ),
                        ),
                        Text(
                          Intl().date('EE').format(date),
                          style: Get.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: cuotaDia
                                ? Get.theme.colorScheme.onPrimary
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}
