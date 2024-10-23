import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductoList extends StatelessWidget {
  const ProductoList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCtrl>(
      init: SearchCtrl(),
      builder: (ctrl) {
        return Obx(
          () {
            if (ctrl.data.isEmpty) {
              return SizedBox(
                height: Get.height / 2,
                child: Center(
                  child: ctrl.loading.isTrue
                      ? const CircularProgressIndicator()
                      : const Text('No hay resultados'),
                ),
              );
            }

            // return Column(
            //   children: ListTile.divideTiles(
            //     context: context,
            //     color: Get.theme.colorScheme.surfaceContainer,
            //     tiles: ctrl.data
            //         .map(
            //           (item) => ListTile(
            //             leadingAndTrailingTextStyle: Get.textTheme.bodySmall,
            //             contentPadding:
            //                 const EdgeInsets.symmetric(horizontal: 20.0),
            //             leading: Container(
            //               width: 100,
            //               height: 200,
            //               color: Get.theme.colorScheme.surfaceContainerHigh,
            //               // child: CachedNetworkImage(
            //               //   imageUrl: '${item.txImagen}',
            //               //   imageBuilder: (context, imageProvider) {
            //               //     return Container(
            //               //       width: double.infinity,
            //               //       height: double.infinity,
            //               //       decoration: BoxDecoration(
            //               //         borderRadius: BorderRadius.circular(10),
            //               //         border: Border.all(
            //               //           color: Get.theme.colorScheme
            //               //               .surfaceContainerHighest,
            //               //         ),
            //               //         image: DecorationImage(
            //               //           fit: BoxFit.contain,
            //               //           image: imageProvider,
            //               //         ),
            //               //       ),
            //               //     );
            //               //   },
            //               // ),
            //             ),
            //             title: Text(
            //               '${item.nbProducto}',
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: const TextStyle(
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             subtitle: Text(
            //               '${item.nuCantidad}',
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: const TextStyle(
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         )
            //         .toList(),
            //   ).toList(),
            // );

            return GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: ctrl.data.length,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: Get.width / 1.5,
                maxCrossAxisExtent: Get.width / 2,
              ),
              itemBuilder: (context, index) {
                SearchProducto item = ctrl.data[index];

                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: '${item.txImagen}',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholder: (context, url) => Shimmer(
                          gradient: LinearGradient(
                            colors: [
                              Get.theme.colorScheme.surface,
                              Get.theme.colorScheme.surfaceContainerLowest
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Get
                                    .theme.colorScheme.surfaceContainerHighest,
                              ),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  Get.theme.colorScheme.surfaceContainerHighest,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Get.theme.colorScheme.surfaceContainerHighest,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.nbProducto}',
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '(${item.nuCantidad}) unidades',
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMonto}'))}',
                                      textAlign: TextAlign.end,
                                      style:
                                          Get.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Bs. ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMonto}') * 39.8)}',
                                      textAlign: TextAlign.end,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );

                // return SvgPicture.network(
                //   '${item.txImagen}',

                //    Container(
                //     clipBehavior: Clip.hardEdge,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(
                //         width: 1,
                //         color: Get.theme.colorScheme.surfaceContainerHighest,
                //       ),

                //     ),
                //   ),
                // );
              },
            );
          },
        );
      },
    );
  }
}
