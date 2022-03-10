import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE User_Places(id PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lon REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> values) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getPlaces(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
