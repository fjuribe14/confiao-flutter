import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductoDetail extends StatelessWidget {
  const ProductoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    double tasa = Get.arguments['tasa'];
    List<Map<String, dynamic>> cuotas = [];
    // Tienda tienda = Get.arguments['tienda'];
    SearchProducto producto = Get.arguments['producto'];
    ModeloFinanciamiento modeloFinanciamiento =
        Get.arguments['modeloFinanciamiento'];
    ShoppingCartCtrl shoppingCartCtrl = Get.find<ShoppingCartCtrl>();

    bool isDisponible = producto.nuCantidad! > 0;

    for (var i = 0; i < modeloFinanciamiento.caCuotas!; i++) {
      cuotas.add({
        'nuCuota': i + 1,
        'moMonto':
            double.parse(producto.moMonto!) / modeloFinanciamiento.caCuotas!,
        'feCuota': Intl().date('yyyy-MM-dd').format(DateTime.now().add(Duration(
            days: ((i + 1) * modeloFinanciamiento.nuDiasEntreCuotas!)))),
      });
    }

    return Obx(() {
      bool inCarrito = shoppingCartCtrl.existInCart(producto);

      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.4,
                  child: CachedNetworkImage(
                    imageUrl: '${producto.txImagen}',
                    cacheKey: '${producto.txImagen}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Get.theme.colorScheme.surfaceContainerHighest,
                        ),
                        image: DecorationImage(image: imageProvider),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${producto.nbProducto}',
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '${producto.txDescripcion}',
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '(${producto.nuCantidad}) unidades',
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${producto.moMonto}'))}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Bs. ${Helper().getAmountFormatCompletDefault(double.parse('${producto.moMonto}') * tasa)}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      if (modeloFinanciamiento.caCuotas != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Inicial',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${Helper().getAmountFormatCompletDefault(double.parse(modeloFinanciamiento.pcInicial!))}%',
                                    style: Get.textTheme.bodyLarge?.copyWith(),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Divider(
                                height: 1.0,
                                color: Get.theme.colorScheme.surfaceContainer,
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Pago',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Cada ${modeloFinanciamiento.nuDiasEntreCuotas} días',
                                    style: Get.textTheme.bodyLarge?.copyWith(),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Divider(
                                height: 1.0,
                                color: Get.theme.colorScheme.surfaceContainer,
                              ),
                              const SizedBox(height: 10.0),
                              ...cuotas.map((cuota) {
                                bool isUltima =
                                    cuota['nuCuota'] == cuotas.length;

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Cuota ${cuota['nuCuota']}',
                                            style: Get.textTheme.bodyLarge
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Get
                                                  .theme.colorScheme.onSurface
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '\$ ${Helper().getAmountFormatCompletDefault(
                                                double.parse(
                                                        '${cuota['moMonto']}')
                                                    .toPrecision(2),
                                              )}',
                                              style: Get.textTheme.bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              'Bs. ${Helper().getAmountFormatCompletDefault(
                                                double.parse(
                                                            '${cuota['moMonto']}')
                                                        .toPrecision(2) *
                                                    tasa,
                                              )}',
                                              style: Get.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Get
                                                    .theme.colorScheme.onSurface
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    if (!isUltima) const SizedBox(height: 5.0),
                                    if (!isUltima)
                                      Divider(
                                        height: 1.0,
                                        color: Get
                                            .theme.colorScheme.surfaceContainer,
                                      ),
                                    if (!isUltima) const SizedBox(height: 10.0),
                                  ],
                                );
                              }),
                            ],
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  onPressed: isDisponible
                      ? () {
                          if (inCarrito) {
                            Get.toNamed(AppRouteName.shoppingCart,
                                arguments: Get.arguments);
                          } else {
                            shoppingCartCtrl.addToCart(producto);
                          }
                          debugPrint(
                              'shoppingCartCtrl.data: ${shoppingCartCtrl.data.length}');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  label: inCarrito
                      ? Text(
                          'Ir al carrito',
                          style: Get.textTheme.titleMedium?.copyWith(
                              color: Get.theme.colorScheme.onPrimary),
                        )
                      : Text(
                          isDisponible ? 'Comprar' : 'No disponible',
                          style: Get.textTheme.titleMedium?.copyWith(
                            color: isDisponible
                                ? Get.theme.colorScheme.onPrimary
                                : Get.theme.colorScheme.onSurface
                                    .withOpacity(0.5),
                          ),
                        ),
                  icon: Icon(
                    Icons.shopping_bag_rounded,
                    color: isDisponible
                        ? Get.theme.colorScheme.onPrimary
                        : Get.theme.colorScheme.onSurface.withOpacity(0.5),
                    size: Get.textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
              if (inCarrito) const SizedBox(width: 10.0),
              if (inCarrito)
                IconButton(
                  onPressed: () {
                    shoppingCartCtrl.removeFromCart(producto);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: Get.theme.colorScheme.error,
                    size: Get.textTheme.titleMedium?.fontSize,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Get.theme.colorScheme.surfaceContainer,
                    padding: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }
}
