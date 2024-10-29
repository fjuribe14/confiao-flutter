import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/controllers/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          Get.find<TiendaCtrl>().getData();
          Get.find<ComunesCtrl>().getData();
          Get.find<FinanciadorCtrl>().getData();
          Get.find<FinanciamientoCtrl>().getData();
        },
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FinanciadorCard(),
              FinanciamientoCard(),
              TiendaList(),
            ],
          ),
        ),
      ),
    );
  }
}
