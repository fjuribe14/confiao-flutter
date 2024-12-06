import 'package:confiao/models/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DbCtrl extends GetxController {
  late Isar isar;

  @override
  void onInit() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = Isar.open(
      directory: dir.path,
      schemas: [PushMessageSchema],
    );
    super.onInit();
  }

// final newUser = User()..name = 'Jane Doe'..age = 36;

// await isar.writeTxn(() async {
//   await isar.users.put(newUser); // insert & update
// });

// final existingUser = await isar.users.get(newUser.id); // get

// await isar.writeTxn(() async {
//   await isar.users.delete(existingUser.id!); // delete
// });

  getPushMessages() async {
    return isar.pushMessages.where().findAll();
  }

  insertPushMessage(PushMessage message) async {
    try {
      await isar.writeAsync((db) => db.pushMessages.put(message));
      debugPrint('push message ${message.messageId} inserted');
    } catch (e) {
      debugPrint('$e');
    }
  }

  updatePushMessage(PushMessage message) async {
    try {
      await isar.writeAsync((db) => db.pushMessages.put(message));
      debugPrint('push message ${message.messageId} updated');
    } catch (e) {
      debugPrint('$e');
    }
  }

  clearPushMessages() async {
    try {
      await isar.writeAsync((db) => db.pushMessages.clear());
      debugPrint('push messages cleared');
    } catch (e) {
      debugPrint('$e');
    }
  }
}
