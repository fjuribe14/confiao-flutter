import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/pages/index.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/controllers/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TiendaDetail extends StatelessWidget {
  const TiendaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TiendaCtrl>(
      init: TiendaCtrl(),
      builder: (ctrl) {
        Tienda item = Get.arguments;

        return Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: ctrl.tabController,
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ), // AppBar
          body: TabBarView(
            children: [
              Center(child: Text('Home')),
              Center(child: Text('Settings')),
            ],
          ),
          // body: SingleChildScrollView(
          //   clipBehavior: Clip.hardEdge,
          //   scrollDirection: Axis.vertical,
          //   controller: ctrl.scrollController,
          //   physics: const AlwaysScrollableScrollPhysics(),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         width: double.infinity,
          //         color: Get.theme.colorScheme.surfaceContainerLow,
          //         padding: const EdgeInsets.symmetric(
          //             horizontal: 20, vertical: 10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             CachedNetworkImage(
          //               width: 100,
          //               height: 100,
          //               imageUrl: '${item.txImagen}',
          //               imageBuilder: (context, imageProvider) => Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                   border: Border.all(
          //                     color: Get
          //                         .theme.colorScheme.surfaceContainerHighest,
          //                   ),
          //                   image: DecorationImage(
          //                       image: imageProvider, fit: BoxFit.cover),
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(width: 10),
          //             Expanded(
          //               flex: 1,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Row(
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Expanded(
          //                         flex: 1,
          //                         child: Text(
          //                           '${item.nbEmpresa}',
          //                           maxLines: 1,
          //                           textAlign: TextAlign.left,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: Get.textTheme.titleLarge?.copyWith(
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                       ),
          //                       // const SizedBox(width: 10),
          //                     ],
          //                   ),
          //                   const SizedBox(height: 5.0),
          //                   Text(
          //                     '${item.txDireccion}',
          //                     maxLines: 2,
          //                     textAlign: TextAlign.left,
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                   if (item.credito == true)
          //                     const SizedBox(height: 5.0),
          //                   if (item.credito == true)
          //                     Row(
          //                       children: [
          //                         Expanded(child: Container()),
          //                         const SizedBox(width: 10),
          //                         ElevatedButton.icon(
          //                           onPressed: () {},
          //                           style: ElevatedButton.styleFrom(
          //                             backgroundColor: Get.theme.colorScheme
          //                                 .surfaceContainerHighest,
          //                             shadowColor: Colors.transparent,
          //                             elevation: 0.0,
          //                           ),
          //                           icon: Icon(
          //                             Icons.credit_card,
          //                             color: Get.theme.colorScheme.primary,
          //                           ),
          //                           label: Text(
          //                             'Céditos',
          //                             style:
          //                                 Get.textTheme.titleMedium?.copyWith(
          //                               fontWeight: FontWeight.bold,
          //                               color: Get.theme.colorScheme.primary,
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     )
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       const SizedBox(height: 20),
          //       const ProductoList(),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
