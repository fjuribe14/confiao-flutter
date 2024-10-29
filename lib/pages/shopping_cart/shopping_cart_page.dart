import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartCtrl>(
      init: ShoppingCartCtrl(),
      builder: (ctrl) {
        final comunesCtrl = Get.find<ComunesCtrl>();
        // final financiadorCtrl = Get.find<FinanciadorCtrl>();

        final tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');

        return Obx(() {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Badge(
                    offset: const Offset(0, 0),
                    label: Text('${ctrl.data.length}'),
                    isLabelVisible: ctrl.data.isNotEmpty,
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.shopping_cart_rounded),
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Text(
                    //     '${financiadorCtrl.data.first.limiteCliente?.moDisponible}'),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: ctrl.data.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        final item = ctrl.data[index];

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Get.theme.colorScheme.onPrimary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                width: 80.0,
                                height: 80.0,
                                imageUrl: '${ctrl.data[index].txImagen}',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider,
                                      ),
                                      border: Border.all(
                                        width: 1.0,
                                        color: Get.theme.colorScheme
                                            .surfaceContainerHighest,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.nbProducto}',
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton.outlined(
                                            onPressed: () {
                                              ctrl.removeOneToCart(item);
                                              ctrl.update();
                                            },
                                            icon: const Icon(Icons.remove),
                                            color: Get.theme.colorScheme.error,
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text('${item.caSelected}'),
                                          const SizedBox(width: 10.0),
                                          IconButton.outlined(
                                            onPressed: () {
                                              ctrl.addOneToCart(item);
                                              ctrl.update();
                                            },
                                            icon: const Icon(Icons.add),
                                            color:
                                                Get.theme.colorScheme.primary,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ctrl.removeFromCart(item);
                                    },
                                    iconSize: 20.0,
                                    icon: const Icon(Icons.close),
                                    color: Get.theme.colorScheme.error,
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMonto}'))}',
                                          textAlign: TextAlign.end,
                                          style: Get.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Bs. ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMonto}') * tasa)}',
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
                        );
                      },
                    ),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRouteName.tiendaDetail,
                          arguments: Get.arguments,
                        );
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        height: 60.0,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color:
                                Get.theme.colorScheme.surfaceContainerHighest,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: Get.textTheme.titleSmall?.fontSize,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              'Agregar más productos',
                              style: Get.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
