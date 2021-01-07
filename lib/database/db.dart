import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';
import 'package:todolist/database/todo_item.dart';

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    try {
      String _path = await getDatabasesPath();
      String _databasepath = p.join(_path, 'todolist.db');

      _db = await openDatabase(_databasepath,
          version: _version, onCreate: onCreate);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> onCreate(Database db, int version) async =>
      await db.execute(
          'CREATE TABLE TODO (id INTEGER PRIMARY KEY NOT NULL, name STRING)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db.query(table);

  static Future<int> insert(String table, ToDoItem toDoItem) async =>
      await _db.insert(table, toDoItem.toMap());

  static Future<int> delete (String table, ToDoItem toDoItem) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [toDoItem.id]);
}
