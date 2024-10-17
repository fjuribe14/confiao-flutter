import 'package:cached_network_image/cached_network_image.dart';
import 'package:confiao/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TiendaList extends StatelessWidget {
  const TiendaList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiendaCtrl>(
      init: TiendaCtrl(),
      builder: (ctrl) {
        return Obx(
          () {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Tiendas',
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 10.0),
                      ElevatedButton.icon(
                        onPressed: () {},
                        iconAlignment: IconAlignment.end,
                        icon: Icon(Icons.chevron_right_outlined,
                            size: Get.textTheme.bodyMedium?.fontSize),
                        label:
                            Text('ver más'.tr, style: Get.textTheme.bodyMedium),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          padding: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    height: 100.0,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: ctrl.loading.value ? 10 : ctrl.data.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      itemBuilder: (context, index) => ctrl.loading.value
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
                              ))
                          : Container(
                              width: 100.0,
                              height: double.infinity,
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                cacheKey: ctrl.data[index].txImagen,
                                imageUrl: '${ctrl.data[index].txImagen}',
                              ),
                            ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
