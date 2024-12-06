import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/helpers/index.dart';
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
                        onTap: () {
                          if (item.status!) {
                            item.status = !item.status!;
                            ctrl.notifications.refresh();
                            ctrl.dbCtrl.updatePushMessage(item);
                          }

                          ctrl.notification.value = item;
                          ctrl.notification.refresh();
                          Get.toNamed(AppRouteName.notificationsDetail);
                        },
                        leading: Icon(
                          item.status!
                              ? Icons.mark_email_unread_outlined
                              : Icons.drafts_outlined,
                          color: item.status!
                              ? Get.theme.colorScheme.error
                              : Get.theme.colorScheme.primary,
                        ),
                        enableFeedback: true,
                        title: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          Helper().dateFormat(
                              dateTime: item.sentDate,
                              format: 'yyyy-MM-dd HH:mm:ss'),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await ctrl.dbCtrl.clearPushMessages();
            ctrl.notifications.clear();
            ctrl.notifications.refresh();
          },
          backgroundColor: Get.theme.colorScheme.error,
          child: Icon(
            Icons.delete_outline,
            color: Get.theme.colorScheme.onError,
          ),
        ),
      ),
    );
  }
}
