import 'dart:developer';

import 'package:counter_app/database/migration.db.dart';
import 'package:counter_app/user/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseConnection extends MigrationDB {
  // 1. open || Create
  Future<Database> initDatanase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (
        Database db,
        int version,
      ) async {
        // if (oldVersion == 1) {
        //   await db.execute('DROP TABLE IF EXISTS Users');
        // }
        await db.execute(
            'CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, position TEXT,salary REAL,experience TEXT NULL)');
      },
    );
  }

  // void _onUpgrade(Database db, int oldVersion, int newVersion) {
  //   if (oldVersion < newVersion) {
  //     db.execute("ALTER TABLE Users ADD COLUMN description TEXT;");
  //   }
  // }

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
    db.update('Users', user.toMap(isAdd: false),
        where: 'id=?', whereArgs: [user.id]);
  }

  // 5. Delete
  Future<void> deleteUser({required int id}) async {
    var db = await initDatanase();
    await db.delete('Users', where: 'id=?', whereArgs: [id]);
  }

  // 6. Search or Filter
  Future<List<UserModel>> getSearchUser({String? search}) async {
    String query = 'SELECT * FROM Users WHERE name LIKE ? OR salary LIKE ?';
    String searchTerm = '%$search%';

    var db = await initDatanase();
    List<Map<String, dynamic>> results =
        await db.rawQuery(query, [searchTerm, searchTerm]);

    return results.map((map) => UserModel.fromMap(map: map)).toList();
  }

  Future<List<UserModel>> getSortUser({int? sort}) async {
    var db = await initDatanase();

    List<Map<String, dynamic>> results = await db.rawQuery(
        ' SELECT * FROM Users ORDER BY salary ${getSortByvalue(sort: sort!)};');

    return results.map((map) => UserModel.fromMap(map: map)).toList();
  }

  String? getSortByvalue({required int sort}) {
    switch (sort) {
      case 0:
        return '';
      case 1:
        return 'DESC';
      case 2:
        return 'ASC';
    }
    return null;
  }
}
