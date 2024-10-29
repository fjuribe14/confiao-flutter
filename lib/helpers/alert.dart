import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:confiao/helpers/index.dart';
// import 'package:confiao/shared/widgets/index.dart';

class AlertService {
  // This function is triggered when the "Show SnackBar" button pressed
  showSnackBar({
    required String title,
    required String body,
    int duration = 6,
    SnackPosition position = SnackPosition.TOP,
    Color? backgroundColor,
    Color? colorText,
  }) {
    Get.snackbar(
      title,
      body,
      duration: Duration(seconds: duration),
      snackPosition: position,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: backgroundColor ?? Get.theme.cardColor,
      margin: const EdgeInsets.all(5.0),
      colorText: colorText,
    );
  }

  // mostrar dialog
  Future showDialog({
    title,
    subtitle,
    required List<Widget> content,
    required List<Widget>? actions,
    Color backgroundColor = Colors.white,
    bool barrierDismissible = true,
  }) async {
    List accionesNew = [];

    if ((actions?.length ?? 0) > 1) {
      accionesNew = actions!
          .map((widget) => [widget, const SizedBox(width: 10)])
          .expand((element) => element)
          .toList();

      accionesNew.removeLast();
    }

    Widget action = Row(
      mainAxisAlignment: ((actions?.length ?? 0) > 1)
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (accionesNew.isNotEmpty) ...[
          ...accionesNew,
        ] else ...[
          ...actions!
        ]
      ],
    );

    return await Get.dialog(
        AlertDialog(
          content: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: Responsive.height(30),
              minWidth: Responsive.width(40),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      Helper().getLogoAppByTheme(),
                      height: Responsive.height(5),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (title is Widget) ...[
                      title
                    ] else if (title is String) ...[
                      Text(
                        title,
                        style: Get.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          // color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                    if (subtitle is Widget) ...[
                      subtitle
                    ] else if (subtitle is String) ...[
                      Text(
                        subtitle,
                        style: Get.theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                    ...content,
                  ],
                ),
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          scrollable: true,
          actions: [action],
        ),
        barrierDismissible: barrierDismissible);
  }

  // This function is triggered when the "Show BottomSheet" button pressed
  showBottomSheet(
      {double heigthPorcent = 50, color, required Widget body}) async {
    await Get.bottomSheet(
      Container(
        width: double.infinity,
        height: Responsive.height(heigthPorcent),
        color: color ?? Get.theme.colorScheme.surface,
        child: body,
      ),
    );
  }

  //generar items el linea tipo clave: valor.
  Widget generateItemBodyDetail(String title, String value) => Tooltip(
        message: value,
        child: GestureDetector(
          onLongPress: () async {
            await Clipboard.setData(ClipboardData(text: value));
            showSnackBar(
              title: 'copied'.tr,
              body: title + 'text_copied'.tr,
              position: SnackPosition.BOTTOM,
              duration: 2,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title: ',
                style: Get.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Text(
                  value,
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 3,
                  style: Get.theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      );

  showLoading(bool show) {
    // print('>>>> loading: ${show} : ${Get.isDialogOpen == true} ');
    if (!show && Get.isDialogOpen == true) {
      //Get.back();
      Navigator.of(Get.overlayContext as BuildContext).pop();
    } else if (show) {
      Get.dialog(
        Container(
          color: Colors.transparent,
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: CircularProgressIndicator(
                  // color: constants.ColorTheme.primary,
                  // backgroundColor: constants.ColorTheme.dark500,
                  ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  showAlertNotPermissionCamera() {
    return showDialog(
      title: 'No se ha concedido permiso a la cámara.',
      subtitle: 'Para continuar debe aceptar los permisos necesarios.',
      content: [],
      actions: [
        // CustomRoundedButton(
        //   text: 'cancel'.tr.toUpperCase(),
        //   press: () => Get.back(),
        //   background: Get.theme.colorScheme.error,
        //   colorText: Get.theme.colorScheme.onError,
        // ),
        // CustomRoundedButton(
        //   text: 'CONFIGURAR',
        //   press: () {
        //     Get.back();
        //     Get.toNamed(AppRouteName.permissionDevice);
        //   },
        // ),
      ],
    );
  }
}
