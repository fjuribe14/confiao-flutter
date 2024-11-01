import 'package:confiao/helpers/index.dart';
import 'package:confiao/models/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    FinanciamientoCtrl financiamientoCtrl = Get.find<FinanciamientoCtrl>();

    debugPrint('${financiamientoCtrl.financiamiento.value.toJson()}');

    return GetBuilder<PagoServicioCtrl>(
      init: PagoServicioCtrl(),
      builder: (ctrl) {
        return PopScope(
          canPop: false,
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
                              color: Get.theme.primaryColor.withOpacity(0.1),
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
                            financiamientoCtrl.financiamiento.value =
                                Financiamiento();
                            Get.back();
                            Get.offAllNamed(AppRouteName.home);
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
              title: const Text('Checkout'),
            ),
            body: const SafeArea(
                child: Column(
              children: [],
            )),
          ),
        );
      },
    );
  }
}
