import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/cuota/cuota_ctrl.dart';

class CuotaPendientesList extends StatelessWidget {
  const CuotaPendientesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CuotaCtrl>(
      init: CuotaCtrl(),
      builder: (ctrl) {
        return Obx(
          () {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cuotas',
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 100.0,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount:
                          ctrl.loading.value ? 10 : ctrl.diasDelMes.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      itemBuilder: (context, index) {
                        return ctrl.loading.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade200,
                                highlightColor: Colors.grey.shade300,
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              )
                            : Container(
                                width: 50.0,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Get.theme.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${ctrl.diasDelMes[index].day}',
                                      style: Get.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
