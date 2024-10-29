import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class ShoppingCartCtrl extends GetxController {
  RxBool loading = false.obs;
  List<SearchProducto> data = <SearchProducto>[].obs;
  FinanciadorCtrl financiadorCtrl = Get.find<FinanciadorCtrl>();

  bool existInCart(SearchProducto item) {
    return data.contains(item);
  }

  addToCart(SearchProducto item) async {
    if (double.parse(item.moMonto!).isGreaterThan(double.parse(
        financiadorCtrl.data.first.limiteCliente!.moDisponible!))) {
      //
      AlertService().showSnackBar(
        title: 'Error',
        body: 'No hay suficiente dinero disponible',
      );
      //
      return;
    } else {
      item.caSelected = 1;
      data.add(item);
      await Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          actionsPadding:
              const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
          titlePadding:
              const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          title: Text(
            'Felicidades!',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Se agregó'),
                TextSpan(
                  text: ' "${item.nbProducto}" ',
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: 'a tu carrito'),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Get.theme.primaryColor.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text(
                          'Seguir viendo',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      Get.back();
                      Get.toNamed(AppRouteName.shoppingCart,
                          arguments: Get.arguments);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
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
                          'Ir al carrito',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    }
  }

  removeFromCart(SearchProducto item) async {
    final bool? result = await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        actionsPadding:
            const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        title: Text(
          '¿ Seguro que desea eliminar ${item.nbProducto} ?',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const SizedBox(height: 0.0),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back(result: false);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Get.theme.primaryColor.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                    Get.back(result: true);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
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
                        'Eliminar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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

    if (result == true) {
      item.caSelected = 0;
      data.remove(item);
    }
  }

  addOneToCart(SearchProducto item) {
    if (item.caSelected.isLowerThan(item.nuCantidad!)) {
      item.caSelected = ++item.caSelected;
      item.moMonto = (double.parse(item.moMonto!) * item.caSelected).toString();
    }
  }

  removeOneToCart(SearchProducto item) {
    if (item.caSelected.isGreaterThan(1)) {
      item.moMonto = (double.parse(item.moMonto!) / item.caSelected).toString();
      item.caSelected = --item.caSelected;
    }
  }

  clearCart() {
    data.clear();
  }
}
