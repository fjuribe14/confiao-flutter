import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FinanciadorCard extends StatelessWidget {
  const FinanciadorCard({super.key});

  @override
  Widget build(BuildContext context) {
    double tasa = 0.0;

    Get.put(FinanciadorCtrl());
    TiendaCtrl tiendaCtrl = Get.put(TiendaCtrl());
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();

    if (comunesCtrl.tasas.isNotEmpty) {
      tasa = double.parse(comunesCtrl.tasas[0].moMonto!);
    }

    return GetBuilder<FinanciadorCtrl>(
      init: FinanciadorCtrl(),
      builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () {
              if (ctrl.loading.isTrue && tiendaCtrl.loading.isTrue) {
                return Shimmer.fromColors(
                  baseColor: Get.theme.colorScheme.surfaceContainer,
                  highlightColor: Get.theme.colorScheme.surfaceContainerHigh,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }

              if (ctrl.data.isEmpty && tiendaCtrl.data.isEmpty) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Center(
                    child: Text('Lo sentimos, no hay financiadores aún.'),
                  ),
                );
              }

              List<String> tiendasID =
                  tiendaCtrl.data.map((e) => '${e.coIdentificacion}').toList();

              List<Financiador> financiadores = ctrl.data.where((e) {
                if (tiendasID.isEmpty) return true;
                if (e.idFinanciador == 1) return true;
                return tiendasID.contains(e.txIdentificacion);
              }).toList();

              for (var e in financiadores) {
                Tienda tienda = tiendaCtrl.data.firstWhere((t) {
                  return t.coIdentificacion == e.txIdentificacion;
                }, orElse: () => Tienda());

                if (tienda.txImagen != null) {
                  e.txImagen = tienda.txImagen;
                }
              }

              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeFactor: 0.2,
                      disableCenter: false,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      scrollPhysics: const BouncingScrollPhysics(),
                      onPageChanged: (index, reason) =>
                          ctrl.index.value = index,
                    ),
                    items: financiadores.map((item) {
                      final bool inAfiliado = item.inAfiliado ?? false;

                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: inAfiliado
                                ? null
                                : () async => await ctrl.cotizar(item),
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              margin: const EdgeInsets.only(bottom: 20.0),
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: inAfiliado
                                    ? LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Get.theme.colorScheme
                                              .onSecondaryFixedVariant,
                                          Get.theme.colorScheme.primary,
                                        ],
                                      )
                                    : LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Get.theme.colorScheme
                                              .surfaceContainerHighest,
                                          Get.theme.colorScheme
                                              .surfaceContainer,
                                        ],
                                      ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
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
                                                'Financiador',
                                                style: Get.textTheme.labelSmall
                                                    ?.copyWith(
                                                  color: inAfiliado
                                                      ? Colors.white
                                                          .withOpacity(0.8)
                                                      : Colors.black
                                                          .withOpacity(0.8),
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                '${item.nbFinanciador}'
                                                    .toUpperCase(),
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.textTheme.bodySmall
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: inAfiliado
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              const Spacer(),
                                              if (inAfiliado)
                                                Text(
                                                  'Disponible',
                                                  style: Get
                                                      .textTheme.labelSmall
                                                      ?.copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              if (inAfiliado)
                                                const SizedBox(height: 2.0),
                                              if (inAfiliado)
                                                Text(
                                                  '\$ ${Helper().getAmountFormatCompletDefault(
                                                    double.parse(item
                                                            .limiteCliente
                                                            ?.moDisponible ??
                                                        '0'),
                                                  )}',
                                                  textAlign: TextAlign.end,
                                                  style: Get
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              if (inAfiliado)
                                                Text(
                                                  'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(item.limiteCliente?.moDisponible ?? '0') * tasa)}',
                                                  textAlign: TextAlign.end,
                                                  style: Get
                                                      .textTheme.titleSmall
                                                      ?.copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 45,
                                              width: 45,
                                              child: CachedNetworkImage(
                                                imageUrl: '${item.txImagen}',
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        SvgPicture.asset(
                                                  AssetsDir.logo,
                                                  width: 45,
                                                  height: 45,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  if (!inAfiliado)
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Get.theme.colorScheme
                                                  .onSecondaryFixedVariant,
                                              Get.theme.colorScheme.primary,
                                            ],
                                          )),
                                      child: Text(
                                        'Solicitar límite',
                                        // 'Cotiza tu financiamiento en ${item.nbFinanciador} dando click aquí.',
                                        textAlign: TextAlign.center,
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color:
                                              Get.theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: financiadores.asMap().entries.map((entry) {
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.only(bottom: 10.0, right: 6.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Get.theme.colorScheme.secondary.withOpacity(
                              ctrl.index.value == entry.key ? 1.0 : 0.3),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
