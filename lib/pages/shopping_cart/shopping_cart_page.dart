import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
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
        List<Map<String, dynamic>> cuotas = [];

        // Producto de crédito
        final bool inFinancia = ctrl.data.first.inFinancia ?? false;

        // Tienda
        TiendaCtrl tiendaCtrl = Get.find<TiendaCtrl>();
        Tienda tienda = tiendaCtrl.tienda.value;

        // Financiador
        FinanciadorCtrl financiadorCtrl = Get.find<FinanciadorCtrl>();

        final financiador = financiadorCtrl.data.firstWhere((f) {
          if (tienda.boFinanciamientoPublic != true) {
            return f.txIdentificacion == tienda.coIdentificacion;
          }

          return f.idFinanciador == 1;
        }, orElse: () => Financiador());

        final moDisponible = double.parse(
          financiador.limiteCliente?.moDisponible ?? '0.0',
        );

        // Modelo Financiamiento
        ModeloFinanciamientoCtrl modeloFinanciamientoCtrl =
            Get.find<ModeloFinanciamientoCtrl>();
        ModeloFinanciamiento modeloFinanciamiento =
            modeloFinanciamientoCtrl.modeloFinanciamiento.value;

        // Tasa valor
        ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();
        double tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');

        return Obx(() {
          // Cuotas
          cuotas.clear();
          //
          int diasAnual = 360;
          int caCuotas = modeloFinanciamiento.caCuotas ?? 0;
          int nuDiasEntreCuotas = modeloFinanciamiento.nuDiasEntreCuotas ?? 0;
          double pcPorCuota =
              double.parse(modeloFinanciamiento.pcTasaInteres ?? '0.0') /
                  diasAnual;
          double moProducto = ctrl.moTotal;
          double moCuota = (moProducto / caCuotas).toPrecision(2);

          double moPcPorCuota = 0.0;
          double moTotalPagar = 0.0;
          //
          if (modeloFinanciamiento.caCuotas != null && ctrl.data.isNotEmpty) {
            for (var i = 0; i < modeloFinanciamiento.caCuotas!; i++) {
              // Si no es la primera cuota se resta el monto de la cuota anterior
              if (i != 0) {
                final cuotaAnterior = cuotas[i - 1];
                moProducto = cuotaAnterior['moProducto'] - moCuota;
                moProducto = moProducto.toPrecision(2);
              }

              double moInteres =
                  ((moProducto * nuDiasEntreCuotas * pcPorCuota) / 100)
                      .toPrecision(2);
              double moTotalCuota = (moCuota + moInteres).toPrecision(2);

              cuotas.add({
                'nuCuota': i + 1,
                'moProducto': moProducto,
                'moCuota': moCuota,
                'moInteres': moInteres,
                'moTotalCuota': moTotalCuota,
                'feCuota': Intl().date('yyyy-MM-dd').format(DateTime.now().add(
                    Duration(
                        days: ((i + 1) *
                            modeloFinanciamiento.nuDiasEntreCuotas!)))),
              });

              moPcPorCuota += moInteres;
              moTotalPagar += moTotalCuota;
            }
          }

          final pcIntereses =
              ((moPcPorCuota / ctrl.moTotal) * 100).toPrecision(0);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Carrito de compras'),
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Disponible en  ',
                              children: [
                                TextSpan(
                                  text: '${tienda.nbEmpresa?.toUpperCase()}',
                                  style:
                                      Get.theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            '\$ ${Helper().getAmountFormatCompletDefault(moDisponible)}',
                            style: Get.theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: ctrl.data.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10.0);
                      },
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
                                          '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMontoSelected}'))}',
                                          textAlign: TextAlign.end,
                                          style: Get.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Bs. ${Helper().getAmountFormatCompletDefault(double.parse('${item.moMontoSelected}') * tasa)}',
                                          textAlign: TextAlign.end,
                                          style: Get.textTheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRouteName.tiendaDetail);
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
                    const SizedBox(height: 20.0),
                    if (modeloFinanciamiento.caCuotas != null &&
                        ctrl.data.isNotEmpty)
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
                                      '\$ ${Helper().getAmountFormatCompletDefault(moTotalPagar)}',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      'Bs. ${Helper().getAmountFormatCompletDefault(moTotalPagar * tasa)}',
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
                              bool isUltima = cuota['nuCuota'] == cuotas.length;

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
                                        child: Text(
                                          'Cuota ${cuota['nuCuota']}',
                                          style:
                                              Get.textTheme.bodyLarge?.copyWith(
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
                                                      '${cuota['moTotalCuota']}')
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
                                                          '${cuota['moTotalCuota']}')
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
                      ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: modeloFinanciamiento.caCuotas != null &&
                    ctrl.data.isNotEmpty
                ? Container(
                    height: 70.0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$ ${Helper().getAmountFormatCompletDefault(moTotalPagar)}',
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Bs. ${Helper().getAmountFormatCompletDefault(moTotalPagar * tasa)}',
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (moDisponible >= ctrl.moTotal) {
                                await Get.put(FinanciamientoCtrl())
                                    .crearFinanciamiento(
                                  productos: ctrl.data,
                                  moPrestamo: ctrl.moTotal,
                                  idEmpresa: tienda.idEmpresa!,
                                  nbEmpresa: tienda.nbEmpresa!,
                                  coIdentificacionEmpresa:
                                      tienda.coIdentificacion!,
                                  idModeloFinanciamiento: modeloFinanciamiento
                                      .idModeloFinanciamiento!,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              backgroundColor: Get.theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              inFinancia ? 'Solicitar' : 'Finalizar',
                              style: Get.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Get.theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          );
        });
      },
    );
  }
}
