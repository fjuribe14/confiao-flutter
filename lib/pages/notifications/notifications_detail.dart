import 'package:confiao/controllers/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsDetail extends StatelessWidget {
  const NotificationsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationCtrl>(
      init: NotificationCtrl(),
      builder: (ctrl) => Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detalles'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Helper().dateFormat(
                    dateTime: ctrl.notification.value.sentDate,
                    format: 'dd/MM/yyyy HH:mm:ss',
                  ),
                  textAlign: TextAlign.start,
                ),
                const Divider(),
                Text(ctrl.notification.value.title),
                const Divider(),
                Text(ctrl.notification.value.body),
              ],
            ),
          ),
        );
      }),
    );
  }
}
