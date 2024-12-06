// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseService {
//   DatabaseService._internal(); //singleton constructor privado
//   static final DatabaseService _instance = DatabaseService._internal();

//   static DatabaseService get instance => _instance;

//   final String _databaseName = "confiao.db";

//   static const pkTableNotifications = 'message_id';
//   static const tableNotifications = 'tb_notifications';

//   Future<Database> get database async {
//     return await _initDatabase();
//   }

//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);

//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     try {
//       await db.execute('DROP TABLE IF EXISTS $tableNotifications');

//       await db.execute('''
//       CREATE TABLE $tableNotifications (
//         $pkTableNotifications PRIMARY KEY,
//         id_cliente INTEGER,
//         title TEXT,
//         body TEXT,
//         sent_date TEXT,
//         data TEXT,
//         image_url TEXT,
//         status TEXT
//       )
//     ''');

//       debugPrint('Database created !!');

//       return db;
//     } catch (e) {
//       debugPrint('$e');
//       return null;
//     }
//   }

// // Helper methods
// //
// // // Inserts a row in the database where each key in the Map is a column name
// // // and the value is the column value. The return value is the id of the
// // // inserted row.
// // Future<int> insert(Map<String, dynamic> row) async {
// //   Database db = await instance.database;
// //   return await db.insert(tableCuenta, row);
// // }
// //
// // // All of the rows are returned as a list of maps, where each map is
// // // a key-value list of columns.
// // Future<List<Map<String, dynamic>>> queryAllRows(
// //     String pkTableParametrosSistema) async {
// //   Database db = await instance.database;
// //   return await db.query(tableCuenta);
// // }
// //
// // // return record from bd
// // Future queryGetById(
// //     {required String tableName,
// //     required String column,
// //     String comparador = '=',
// //     required int value}) async {
// //   Database db = await instance.database;
// //   return await db.rawQuery(
// //       'SELECT * FROM $tableName where $column $comparador ?', [value]);
// // }
// //
// // // All of the methods (insert, query, update, delete) can also be done using
// // // raw SQL commands. This method uses a raw query to give the row count.
// // Future<int?> queryRowCount() async {
// //   Database db = await instance.database;
// //   return Sqflite.firstIntValue(
// //       await db.rawQuery('SELECT COUNT(*) FROM $tableCuenta'));
// // }
// //
// // // We are assuming here that the id column in the map is set. The other
// // // column values will be used to update the row.
// // Future<int> update(Map<String, dynamic> row) async {
// //   Database db = await instance.database;
// //   int id = row['id_cliente'];
// //   return await db
// //       .update(tableCuenta, row, where: 'id_cliente = ?', whereArgs: [id]);
// // }
// //
// // // Deletes the row specified by the id. The number of affected rows is
// // // returned. This should be 1 as long as the row exists.
// // Future<int> delete(int id) async {
// //   Database db = await instance.database;
// //   return await db
// //       .delete(tableCuenta, where: 'id_cliente = ?', whereArgs: [id]);
// // }
// }
