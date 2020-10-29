import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reflectable/reflectable.dart';

import 'package:analytics/database/model.dart';

class Settings extends StatelessWidget {
  Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Test'),
            onPressed: () async {
              debugPrint("Testing ORM solution");

              const reflector = const Reflector();

              await openDatabase('analytics', version: 1,
                  onCreate: (Database db, int version) async {
                String table = AnalysisFile().table();
                InstanceMirror mirror = reflector.reflect(AnalysisFile());
                for (var v in mirror.type.typeVariables) {
                  debugPrint(v.toString());
                }

                await db.execute('''
                    CREATE TABLE $table (
                      id integer primary key autoincrement,

                    )
                    ''');
              });
            },
          ),
        ],
      ),
    );
  }
}

class Reflector extends Reflectable {
  const Reflector() : super(invokingCapability);
}
