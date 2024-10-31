import 'package:confiao/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagoServicioList extends StatelessWidget {
  const PagoServicioList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagoServicioCtrl>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pagos de servicios'),
        ),
        body: const SafeArea(child: Center(child: Text('Pagos de servicios'))),
      );
    });
  }
}
