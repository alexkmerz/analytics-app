library analytics.db;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/foundation.dart';
import './file.dart';

class DB {
  Database database;

  init(String database) async {
    debugPrint("DB init");

    String path = await getDatabasesPath();
    path = join(path, database);

    this.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE files (id INTEGER PRIMARY KEY, path TEXT, status TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP)');
    });

    debugPrint("DB init complete");
  }

  insertFile(FF file) async {
    await database.transaction((t) async {
      int id = await t.rawInsert(file.toSQL(), file.params());
      debugPrint("Inserted $id into files table");
    });
  }

  Future<FF> retrieveFiles() async {
    List<Map> maps = await database.query(
      'files',
      columns: ['id', 'path', 'status', 'created_at', 'updated_at'],
    );
  }
}
