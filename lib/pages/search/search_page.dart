import 'package:cached_network_image/cached_network_image.dart';
import 'package:confiao/helpers/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCtrl>(
      init: SearchCtrl(),
      builder: (ctrl) {
        return Obx(() {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: ctrl.queryController,
                              onChanged: (value) {
                                ctrl.queryController.text = value;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Buscar',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          IconButton(
                            onPressed: () {
                              ctrl.getData();
                            },
                            icon: const Icon(Icons.search),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ...ctrl.data.map(
                      (e) => ListTile(
                        onTap: () {},
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            imageUrl: '${e.txImagen}',
                          ),
                        ),
                        title: Text('${e.nbProducto}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$ ${Helper().getAmountFormatCompletDefault(double.parse('${e.moMonto}'))}',
                              textAlign: TextAlign.end,
                              style: Get.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Bs ${Helper().getAmountFormatCompletDefault(double.parse('${e.moMonto}') * 36.75)}',
                              textAlign: TextAlign.end,
                              style: Get.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        subtitle: Text('${e.txDescripcion}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
