import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TiendaCard extends StatelessWidget {
  const TiendaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TiendaCtrl(),
      builder: (ctrl) {
        final financiamientoCtrl = Get.find<FinanciamientoCtrl>();
        final financiamiento = financiamientoCtrl.financiamiento.value;

        ctrl.getDataBy(queryParameters: {
          'co_identificacion': financiamiento.coIdentificacionEmpresa,
        });

        return SizedBox(
          height: 100,
          width: double.infinity,
          child: Obx(
            () {
              if (ctrl.loading.value &&
                  ctrl.tienda.value.coIdentificacion == null) {}

              if (ctrl.tienda.value.coIdentificacion == null) {
                return Shimmer.fromColors(
                  baseColor: Get.theme.colorScheme.surfaceContainerHigh,
                  highlightColor: Get.theme.colorScheme.surfaceContainerLow,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }

              return Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      cacheKey: '${ctrl.tienda.value.txImagen}',
                      imageUrl: '${ctrl.tienda.value.txImagen}',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Get
                                    .theme.colorScheme.surfaceContainerHighest),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ctrl.tienda.value.nbEmpresa}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${ctrl.tienda.value.coIdentificacion}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
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
