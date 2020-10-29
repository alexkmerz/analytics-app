library analytics.models;

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Recording {
  int id;
  String path;
  String status;

  Recording();

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{
      'path': path,
      'status': status,
    };
    if (id != null) data['id'] = id;
    return data;
  }

  fromMap(Map<String, dynamic> map) {
    id = map['id'];
    path = map['title'];
    status = map['status'];
  }
}

class RecordingProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table recording(
          
        )
      ''');
    });
  }
}
