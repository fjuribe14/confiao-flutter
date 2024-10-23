import 'package:confiao/pages/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
import 'package:confiao/controllers/index.dart';

class FinanciamientoList extends StatelessWidget {
  const FinanciamientoList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FinanciamientoCtrl>(
      init: FinanciamientoCtrl(),
      builder: (ctrl) {
        return Obx(
          () {
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
                      Container(
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
                                    borderRadius: BorderRadius.circular(20.0)),
                                side: BorderSide(
                                    color: Get.theme.colorScheme.primary),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ...ctrl.data.map(
                        (item) => ListTile(
                          dense: true,
                          onTap: () => Get.bottomSheet(
                            const FinanciamientoDetail(),
                            enableDrag: true,
                            backgroundColor: Get.theme.scaffoldBackgroundColor,
                            settings: RouteSettings(
                              arguments: item,
                              name: AppRouteName.financiamientoDetail,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          leading: Icon(
                            Icons.monetization_on_outlined,
                            color: Get.theme.colorScheme.primary,
                            size: 40.0,
                          ),
                          title: Text(
                            '#${item.idFinanciamiento}',
                            style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Cuotas ${item.cuotas?.length}',
                            style: Get.textTheme.bodyMedium?.copyWith(),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$ ${Helper().getAmountFormatCompletDefault(double.parse(item.moPrestamo!))}',
                                textAlign: TextAlign.end,
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Bs. ${Helper().getAmountFormatCompletDefault(double.parse(item.moPrestamo!) * 39.8)}',
                                textAlign: TextAlign.end,
                                style: Get.textTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
