import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confiao/controllers/index.dart';
import 'package:confiao/models/financiamiento/financiamiento.dart';

class FinanciamientoList extends StatelessWidget {
  const FinanciamientoList({super.key});

  @override
  Widget build(BuildContext context) {
    ComunesCtrl comunesCtrl = Get.find<ComunesCtrl>();
    final double tasa = double.parse(comunesCtrl.tasas[0].moMonto ?? '0.0');

    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
        if (Get.arguments?['status'] != null) {
          ctrl.statusSelected.value = Get.arguments?['status'];
        }

        return Obx(() {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  ctrl.statusSelected.value = 0;
                  ctrl.getData();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(
                'Financiamientos',
                style: Get.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => ctrl.getData(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: ctrl.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: ctrl.status.length,
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10.0),
                            itemBuilder: (context, index) {
                              String item = ctrl.status[index];
                              bool itemSelected =
                                  ctrl.statusSelected.value == index;

                              return GestureDetector(
                                onTap: () {
                                  ctrl.showHistorial.value = false;
                                  ctrl.statusSelected.value = index;
                                  ctrl.getData();
                                },
                                child: Chip(
                                  clipBehavior: Clip.antiAlias,
                                  label: Text(
                                    item.toCapitalized(),
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                      color: itemSelected
                                          ? Get.theme.colorScheme.onPrimary
                                          : Get.theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  backgroundColor: itemSelected
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  side: BorderSide(
                                      color: Get.theme.colorScheme.primary),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          ctrl.showHistorial.value = !ctrl.showHistorial.value;
                          ctrl.statusSelected.value = 0;
                          ctrl.getData();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: ctrl.showHistorial.isTrue
                              ? Get.theme.colorScheme.primary
                              : Get.theme.colorScheme.onPrimary,
                        ),
                        icon: Icon(
                          Icons.history_rounded,
                          color: ctrl.showHistorial.isTrue
                              ? Get.theme.colorScheme.onPrimary
                              : Get.theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                    ]),
                    const SizedBox(height: 20.0),
                    if (ctrl.loading.isTrue)
                      SizedBox(
                        height: Get.height / 1.5,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (ctrl.loading.isFalse)
                      ...(ctrl.showHistorial.isTrue
                              ? ctrl.dataHistorial
                              : ctrl.data)
                          .map(
                        (item) => ListTile(
                          dense: true,
                          onTap: () {
                            ctrl.financiamiento.value = item;
                            Get.bottomSheet(
                              SizedBox(
                                  height: Get.height / 1.25,
                                  child: const FinanciamientoDetail()),
                              enableDrag: true,
                              isScrollControlled: true,
                              backgroundColor:
                                  Get.theme.scaffoldBackgroundColor,
                              settings: const RouteSettings(
                                name: AppRouteName.financiamientoDetail,
                              ),
                            ).whenComplete(() {
                              ctrl.financiamiento.value = Financiamiento();
                            });
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          leading: SvgPicture.asset(AssetsDir.logo,
                              height: 30, width: 30),
                          title: Text(
                            '#${item.idFinanciamiento} - ${(item.inCredito ?? false) ? 'Crédito' : 'Producto'}',
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: SizedBox(
                            height: 5,
                            child: ListView.separated(
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 5),
                              itemCount: item.cuotas!.length,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                height: 5,
                                width: 10,
                                decoration: BoxDecoration(
                                  color:
                                      ctrl.getColorCuota(item.cuotas![index]),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$ ${Helper().getAmountFormatCompletDefault(double.parse(item.moTotalFinanc!))}',
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(item.moTotalFinanc!) * tasa)}',
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                        'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(comunesCtrl.tasas[0].moMonto!))}',
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
          );
        });
      },
    );
  }
}
