import 'package:cached_network_image/cached_network_image.dart';
import 'package:confiao/controllers/index.dart';
import 'package:confiao/models/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaDetail extends StatelessWidget {
  const TiendaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiendaCtrl>(
        init: TiendaCtrl(),
        builder: (ctrl) {
          Tienda item = Get.arguments;

          debugPrint(item.toJson().toString());

          return Scaffold(
              appBar: AppBar(), // AppBar
              body: SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                controller: ctrl.scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${item.txImagen}',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 100,
                      height: 100,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                Get.theme.colorScheme.surfaceContainerHighest,
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${item.nbEmpresa}',
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('${item.txDireccion}'),
                    const SizedBox(height: 20),
                    GridView.builder(
                      itemCount: 4,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: ctrl.scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: Get.width / 2,
                        mainAxisExtent: Get.width / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) => Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color:
                                Get.theme.colorScheme.surfaceContainerHighest,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Item ${index + 1}',
                            style: Get.textTheme.titleSmall,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
