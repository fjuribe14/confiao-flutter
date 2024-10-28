import 'package:confiao/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartCtrl>(
      init: ShoppingCartCtrl(),
      builder: (ctrl) {
        final financiadorCtrl = Get.find<FinanciadorCtrl>();

        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Text(
                      '${financiadorCtrl.data.first.limiteCliente?.moDisponible}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
