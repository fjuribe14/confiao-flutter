import 'dart:io';
import 'package:confiao/controllers/auth/auth_ctrl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:confiao/models/index.dart';
import 'package:confiao/helpers/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationCtrl extends GetxController {
  RxInt notificationCount = 0.obs;
  late NotificationSettings settings;
  RxList<PushMessage> notifications = <PushMessage>[].obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void onInit() async {
    // await requestpermission();
    super.onInit();
  }

  Iterable<PushMessage> get notificationsUnread =>
      notifications.where((item) => item.status!);

  requestPermissions() async {
    settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      carPlay: false,
      provisional: false,
      announcement: false,
      criticalAlert: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('User notifications declined or has not accepted permission');
      await secureStorage.write(
          key: StorageKeys.storageItemPermissionsNotifications, value: 'false');
    } else {
      debugPrint('User notifications granted  permission');

      await secureStorage.write(
          key: StorageKeys.storageItemPermissionsNotifications, value: 'true');

      await LocalNotifications().initializeLocalNotifications();

      final fcmToken = await messaging.getToken();

      debugPrint('fcmToken: $fcmToken');

      await Http().http(showLoading: false).then(
        (http) async {
          var deviceInfo = await DeviceInfoService().getDeviceInfo;
          final authCtrl = Get.find<AuthCtrl>();

          await http.post(
            '${dotenv.env['URL_API_GTW']}${ApiUrl.apiRegistrarDispositivo}',
            data: {
              "tx_data": '',
              "nb_servicio": 'CONFIAO',
              "tx_token_firebase": fcmToken,
              "tx_usuario": authCtrl.currentUser?.username,
              "co_dispositivo": Platform.isAndroid
                  ? deviceInfo['id']
                  : deviceInfo['identifierForVendor'],
            },
          );
        },
      );

      _onForegroundMessage();
    }
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void handleRemoteMessage(RemoteMessage message) {
    // debugPrint('Got a message whilst in the foreground!');
    // debugPrint('Message data: ${message.data}');

    if (message.notification == null) return;

    // debugPrint('push notification received');

    final notification = PushMessage(
      status: true,
      data: message.data,
      body: message.notification!.body ?? '',
      title: message.notification!.title ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
    );

    notificationCount.value = notificationCount.value + 1;

    LocalNotifications.showLocalNotification(
      id: notificationCount.value,
      title: notification.title,
      body: notification.body,
      data: notification.messageId,
    );

    debugPrint("handleRemoteMessage ${notification.toString()}");

    notifications.add(notification);
    notifications.value = notifications.reversed.toList();
    notifications.refresh();
    update();
  }
}
