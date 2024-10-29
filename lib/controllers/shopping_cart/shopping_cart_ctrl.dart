import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class ShoppingCartCtrl extends GetxController {
  RxBool loading = false.obs;
  RxList<SearchProducto> data = <SearchProducto>[].obs;
  FinanciadorCtrl financiadorCtrl = Get.find<FinanciadorCtrl>();

  double get moTotal =>
      data.map((e) => e.moMontoSelected).reduce((a, b) => a + b);

  bool existInCart(SearchProducto item) {
    return data.contains(item);
  }

  bool hasCredit() {
    return data.any((e) => e.nbCategoria == 'Crédito');
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
      final bool creditResult = hasCredit();

      if (item.nbCategoria == 'Crédito') {
        if (await removeCategoryDialog()) {
          data.removeWhere((e) => e.idCategoria != item.idCategoria);
        }
      } else {
        if (creditResult) {
          if (await removeCategoryDialog()) {
            data.removeWhere((e) => e.nbCategoria == 'Crédito');
          }
        }
      }

      item.caSelected = 1;
      data.add(item);
      data.refresh();

      addToCartDialog(item);
    }
  }

  removeFromCart(SearchProducto item) async {
    final bool result = await removeFromCartDialog(item);

    if (result == true) {
      item.caSelected = 0;
      data.remove(item);
    }

    data.refresh();
  }

  addOneToCart(SearchProducto item) {
    if (item.caSelected.isLowerThan(item.nuCantidad!)) {
      item.caSelected = ++item.caSelected;
      item.moMontoSelected = item.moMontoSelected + double.parse(item.moMonto!);
    }

    data.refresh();
  }

  removeOneToCart(SearchProducto item) {
    if (item.caSelected.isGreaterThan(1)) {
      item.moMontoSelected = item.moMontoSelected - double.parse(item.moMonto!);
      item.caSelected = --item.caSelected;
    }

    data.refresh();
  }

  Future<bool> addToCartDialog(SearchProducto item) async {
    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        actionsPadding:
            const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    Get.back(result: false);
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
                    Get.back(result: true);
                    Get.toNamed(AppRouteName.shoppingCart);
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

  Future<bool> removeFromCartDialog(SearchProducto item) async {
    return await Get.dialog(
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
  }

  Future<bool> removeCategoryDialog() async {
    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        actionsPadding:
            const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        title: Text(
          '¿ Seguro que desea continuar ?',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
            'Se eliminarán todos los productos diferentes a esta categoría'),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back(result: false);
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
                    Get.toNamed(AppRouteName.shoppingCart);
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
                        'Continuar',
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

  clearCart() {
    data.clear();
    data.refresh();
  }
}
