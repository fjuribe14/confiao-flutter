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
      data.add(item);
      await Get.dialog(
        AlertDialog(
          content: Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'Se agregó'),
              TextSpan(text: '${item.nbProducto}'),
              const TextSpan(text: ' a tu carrito'),
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Seguir comprando'),
            ),
          ],
        ),
        barrierDismissible: false,
        barrierColor: Colors.black45,
      );
    }
  }

  removeFromCart(SearchProducto item) {
    data.remove(item);
  }

  clearCart() {
    data.clear();
  }
}
