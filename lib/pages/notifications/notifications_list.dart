import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/controllers/index.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationCtrl>(
      init: NotificationCtrl(),
      builder: (ctrl) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notificaciones',
            style:
                Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Obx(
            () {
              if (ctrl.notifications.isEmpty) {
                return const Center(
                  child: Text('No hay notificaciones aún'),
                );
              }

              return SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: ctrl.notifications.map(
                    (item) {
                      return ListTile(
                        // enabled: false,
                        onTap: () {
                          item.status = !item.status!;
                          ctrl.notifications.refresh();
                        },
                        leading: Icon(item.status! ? Icons.abc : Icons.ac_unit),
                        enableFeedback: true,
                        title: Text(item.title),
                        subtitle: Text(item.body),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
