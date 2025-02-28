import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TiendaList extends StatelessWidget {
  const TiendaList({super.key});

  @override
  Widget build(BuildContext context) {
    TiendaCtrl ctrl = Get.put(TiendaCtrl(), permanent: true);

    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Tiendas',
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                'Encontramos ${ctrl.data.length} tiendas',
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
                          baseColor: Get.theme.colorScheme.surfaceContainer,
                          highlightColor:
                              Get.theme.colorScheme.surfaceContainerHigh,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            ctrl.tienda.value = ctrl.data[index];
                            ctrl.tienda.refresh();
                            Get.toNamed(AppRouteName.tiendaDetail);
                          },
                          child: Container(
                            width: 100.0,
                            height: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Get
                                    .theme.colorScheme.surfaceContainerHighest,
                              ),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              cacheKey: ctrl.data[index].txImagen,
                              imageUrl: '${ctrl.data[index].txImagen}',
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(8.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
