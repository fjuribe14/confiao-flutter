import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';
import 'package:shimmer/shimmer.dart';

class FinanciadorCard extends StatelessWidget {
  const FinanciadorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinanciadorCtrl>(
      init: FinanciadorCtrl(),
      builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () {
              if (ctrl.loading.isTrue) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }

              final item = ctrl.data.first;

              if (item.isBlank!) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Get.theme.primaryColor,
                  child: const Center(
                    child: Text('No tenemos financiadores registrados.'),
                  ),
                );
              }

              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsDir.logo,
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          item.nbFinanciador!,
                          style: Get.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // if (item.inAfiliado!)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          item.inAfiliado!
                              ? Text(
                                  '${item.limiteCliente}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                )
                              : Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Get.theme.colorScheme.primary,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Cotizar',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        color: Get.theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    // if (!item.inAfiliado!)
                    //   Row(
                    //     children: [

                    //     ],
                    //   )
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
