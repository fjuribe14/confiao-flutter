import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductoList extends StatelessWidget {
  const ProductoList({super.key});

  @override
  Widget build(BuildContext context) {
    TiendaCtrl tiendaCtrl = Get.find<TiendaCtrl>();
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();

    Tienda tienda = tiendaCtrl.tienda.value;
    final modeloFinanciamientoCtrl = Get.put(ModeloFinanciamientoCtrl());

    return GetBuilder<SearchCtrl>(
      init: SearchCtrl(),
      builder: (ctrl) {
        final double tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');

        return Obx(() {
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

              return InkWell(
                onTap: () async {
                  bool isCredito = item.nbCategoria == 'Crédito';

                  final idModeloFinanciamiento =
                      tienda.empresaModeloFinanciamiento
                          ?.where((e) {
                            if (isCredito) {
                              return e.txTipoModeloFinanciamiento == 'CREDITO';
                            }

                            return e.txTipoModeloFinanciamiento == 'PUBLICO';
                          })
                          .first
                          .idModeloFinanciamiento;

                  await modeloFinanciamientoCtrl
                      .getDataById(idModeloFinanciamiento);

                  Get.toNamed(AppRouteName.productoDetail, arguments: {
                    'tasa': tasa,
                    'producto': item,
                    'modeloFinanciamiento':
                        modeloFinanciamientoCtrl.modeloFinanciamiento.value
                  });
                },
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: '${item.txImagen}',
                        cacheKey: '${item.txImagen}',
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          Text(
                            '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMonto}'))}',
                            textAlign: TextAlign.end,
                            style: Get.textTheme.titleMedium?.copyWith(
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
              );
            },
          );
        });
      },
    );
  }
}
