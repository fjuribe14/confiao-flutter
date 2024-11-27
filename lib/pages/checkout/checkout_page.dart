import 'package:confiao/pages/index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    FinanciamientoCtrl financiamientoCtrl = Get.find<FinanciamientoCtrl>();

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
          child: Obx(() {
            final tasa = ctrl.tasa.value;

            return Scaffold(
              appBar: AppBar(
                title: Text('Pagar',
                    style: Get.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                          clipBehavior: Clip.hardEdge,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              ...financiamientoCtrl.cuotasSelected.map(
                                (cuota) => ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  title: Text(
                                    'Cuota #${cuota.nuCuota}'.toCapitalized(),
                                    style: Get.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: financiamientoCtrl
                                          .getColorCuota(cuota),
                                    ),
                                  ),
                                  subtitle: Text(
                                    Intl()
                                        .date('dd-MM-yyyy')
                                        .format(cuota.feCuota!),
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$ ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moTotalCuota!))}',
                                        textAlign: TextAlign.end,
                                        style:
                                            Get.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(cuota.moTotalCuota!) * tasa)}',
                                        textAlign: TextAlign.end,
                                        style: Get.textTheme.bodyMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    if (financiamientoCtrl.cuotasSelected[0].moSaldoCuota !=
                        null)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AmortizacionCuotas(
                          tasa: tasa,
                          cuotas: financiamientoCtrl.cuotasSelected,
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Total'.toCapitalized(),
                              style: Get.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ ${Helper().getAmountFormatCompletDefault(financiamientoCtrl.moTotalCuotasSelected)}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Bs. ${Helper().getAmountFormatCompletDefault(financiamientoCtrl.moTotalCuotasSelected * tasa)}',
                                  textAlign: TextAlign.end,
                                  style: Get.textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          ...ctrl.metodosPago.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: ctrl.loading.value
                                      ? null
                                      : () async =>
                                          await ctrl.checkout(e['type']),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    backgroundColor:
                                        Get.theme.colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                  child: Text(
                                    '${e['label']}',
                                    style: Get.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Get.theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
