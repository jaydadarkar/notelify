import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ThemeModel {
  static final _dbName = 'notelify.db';
  static final _dbVersion = 1;
  static final _tableName = 'app_config';
  static final id = '_id';
  static final attribute = 'attribute';
  static final value = 'value';
  static final createdAt = 'created_at';
  static final updatedAt = 'updated_at';

  ThemeModel._privateConstructor();
  static final ThemeModel instance = ThemeModel._privateConstructor();

  Future _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName (
        $id INTEGER PRIMARY KEY,
        $attribute TEXT NOT NULL,
        $value TEXT NOT NULL,
        $createdAt TEXT,
        $updatedAt TEXT
      )
      ''');
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initiateDatabase();
      return _database;
    }
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(_tableName, row, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$id = ?', whereArgs: [id]);
  }
}
