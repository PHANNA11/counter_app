import 'dart:developer';

import 'package:counter_app/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  // 1. open || Create
  Future<Database> initDatanase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, position TEXT,salary REAL)');
    });
  }

  // 2. insert
  Future<void> insertUser({required UserModel user}) async {
    var db = await initDatanase();
    await db.insert('Users', user.toMap());
    log('data was added');
  }

  // 3. Get data
  Future<List<UserModel>> getUserList() async {
    var db = await initDatanase();
    List<Map<String, dynamic>> results = await db.query('Users');

    return results.map((map) => UserModel.fromMap(map: map)).toList();
  }

  // 4. Update
  Future<void> updateUser({required UserModel user}) async {
    var db = await initDatanase();
    db.update('Users', user.toMap(), where: 'id=?', whereArgs: [user.id]);
  }

  // 5. Delete
  Future<void> deleteUser({required int id}) async {
    var db = await initDatanase();
    await db.delete('Users', where: 'id=?', whereArgs: [id]);
  }
}
