import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TiendaDetail extends StatelessWidget {
  const TiendaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiendaCtrl>(
      init: TiendaCtrl(),
      builder: (ctrl) {
        Tienda item = ctrl.tienda.value;
        final searchCtrl = Get.put(SearchCtrl());
        final comunesCtrl = Get.find<ComunesCtrl>();
        final shoppingCartCtrl = Get.put(ShoppingCartCtrl());

        return Obx(() {
          return PopScope(
            canPop: shoppingCartCtrl.data.isEmpty,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;

              return await Get.dialog(
                barrierDismissible: false,
                AlertDialog(
                  contentPadding: const EdgeInsets.all(16.0),
                  actionsPadding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  titlePadding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  title: Text(
                    '¿ Seguro que quieres salir ?',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text(
                    'Si sales, perderás todos tus productos del carrito de compras',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium,
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              width: double.infinity,
                              height: Get.height * 0.075,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Get.theme.primaryColor
                                    .withValues(alpha: 0.1),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancelar',
                                  style: Get.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              shoppingCartCtrl.clearCart();
                              Get.back();
                              Get.offAllNamed(AppRouteName.home)?.then((value) {
                                Get.put(TiendaCtrl());
                                Get.put(FinanciadorCtrl());
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: Get.height * 0.075,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Get.theme.primaryColor,
                                    Get.theme.colorScheme.secondary,
                                  ],
                                  end: Alignment.topRight,
                                  begin: Alignment.bottomLeft,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  'Continuar',
                                  style: Get.textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Badge(
                      offset: const Offset(0, 0),
                      label: Text('${shoppingCartCtrl.data.length}'),
                      isLabelVisible: shoppingCartCtrl.data.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(AppRouteName.shoppingCart);
                        },
                        icon: const Icon(Icons.shopping_cart_rounded),
                      ),
                    ),
                  )
                ],
              ), // AppBar
              body: SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                controller: ctrl.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Get.theme.colorScheme.surfaceContainerLow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            width: 100,
                            height: 100,
                            imageUrl: '${item.txImagen}',
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Get.theme.colorScheme.onPrimary,
                                ),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${item.nbEmpresa}',
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Get.textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  '${item.txDireccion}',
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (item.credito == true)
                                  const SizedBox(height: 5.0),
                                if (item.credito == true)
                                  Obx(() {
                                    return Row(
                                      children: [
                                        Expanded(child: Container()),
                                        const SizedBox(width: 10),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            searchCtrl.isCredito.value =
                                                !searchCtrl.isCredito.value;
                                            await searchCtrl.getData();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Get
                                                .theme
                                                .colorScheme
                                                .surfaceContainerHighest,
                                            shadowColor: Colors.transparent,
                                            elevation: 0.0,
                                          ),
                                          icon: Icon(
                                            searchCtrl.isCredito.value
                                                ? Icons.arrow_back
                                                : Icons.credit_card,
                                            color:
                                                Get.theme.colorScheme.primary,
                                          ),
                                          label: Text(
                                            searchCtrl.isCredito.value
                                                ? 'Volver'
                                                : 'Créditos',
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Get.theme.colorScheme.primary,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const ProductoList(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (comunesCtrl.tasas.isNotEmpty)
                    TextButton(
                      onPressed: null,
                      style: TextButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.primary,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$ ${Helper().getAmountFormatCompletDefault(1.0)}',
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Get.theme.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.switch_left_rounded,
                            color: Get.theme.colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(comunesCtrl.tasas.first.moMonto ?? '0.0'))}',
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Get.theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
