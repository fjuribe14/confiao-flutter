import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductoDetail extends StatelessWidget {
  const ProductoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    List<CuotaPreview> cuotas = [];
    ShoppingCartCtrl shoppingCartCtrl = Get.find<ShoppingCartCtrl>();

    // Modelo Financiamiento
    ModeloFinanciamientoCtrl modeloFinanciamientoCtrl =
        Get.find<ModeloFinanciamientoCtrl>();
    ModeloFinanciamiento modeloFinanciamiento =
        modeloFinanciamientoCtrl.modeloFinanciamiento.value;

    // Tasa valor
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();
    double tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');

    // Producto
    SearchCtrl searchCtrl = Get.find<SearchCtrl>();
    SearchProducto producto = searchCtrl.producto.value;

    double moProducto = double.parse(producto.moMonto ?? '0.0').toPrecision(2);

    final preview = Helper().previewFinanciamiento(
      montoFinanciamiento: moProducto,
      modeloFinanciamiento: modeloFinanciamiento,
    );

    double moPcInicial = preview.moPcInicial!;
    double pcIntereses = preview.pcIntereses!;
    double moTotalPagar = preview.moTotalPagar!;

    cuotas.addAll(preview.cuotas!);

    return Obx(() {
      bool isDisponible = producto.nuCantidad! > 0;
      bool inCarrito = shoppingCartCtrl.existInCart(producto);

      return Scaffold(
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
        ),
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: imageProvider),
                        border: Border.all(
                          color: Get.theme.colorScheme.surfaceContainerHighest,
                        ),
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
                        // maxLines: 4,
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '(${producto.nuCantidad}) unidades disponibles',
                            style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${producto.moMonto ?? 0.0}'))}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Bs. ${Helper().getAmountFormatCompletDefault(double.parse('${producto.moMonto ?? 0.0}') * tasa)}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleMedium?.copyWith(
                                    color: Get.theme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Inicial',
                                        style:
                                            Get.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        '${Helper().getAmountFormatCompletDefault(double.parse(modeloFinanciamiento.pcInicial!))}%',
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color: Get.theme.colorScheme.onSurface
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$ ${Helper().getAmountFormatCompletDefault(moPcInicial)}',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      'Bs. ${Helper().getAmountFormatCompletDefault(moPcInicial * tasa)}',
                                      style: Get.textTheme.bodySmall?.copyWith(
                                        color: Get.theme.colorScheme.onSurface
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Intereses',
                                        style:
                                            Get.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '+$pcIntereses%',
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color: Get.theme.colorScheme.onSurface
                                              .withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$ ${Helper().getAmountFormatCompletDefault((moTotalPagar - moPcInicial))}',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      'Bs. ${Helper().getAmountFormatCompletDefault((moTotalPagar - moPcInicial) * tasa)}',
                                      style: Get.textTheme.bodySmall?.copyWith(
                                        color: Get.theme.colorScheme.onSurface
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
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
                              bool isUltima = cuota.nuCuota == cuotas.length;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Cuota ${cuota.nuCuota}',
                                              style: Get.textTheme.bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Get
                                                    .theme.colorScheme.onSurface
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(
                                              '${cuota.feCuota}',
                                              style: Get.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Get
                                                    .theme.colorScheme.onSurface
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
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
                                                      '${cuota.moTotalCuota}')
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
                                                          '${cuota.moTotalCuota}')
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
                            Get.toNamed(AppRouteName.shoppingCart);
                          } else {
                            shoppingCartCtrl.addToCart(producto);
                          }
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
