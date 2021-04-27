import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' ;
import 'package:todolist/databaseConstants.dart';
import 'dart:async';
import 'notes.dart';

class DB {
  DB._init();

  static final DB instance = DB._init();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('notes.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    String _platformDatabasePath = await getDatabasesPath();
    String _databasePath = join(_platformDatabasePath, filePath);

    return await openDatabase(_databasePath,
        version: databaseVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $databaseTableName (
  ${DatabaseColumnNames.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${DatabaseColumnNames.title} TEXT NOT NULL,
  ${DatabaseColumnNames.description} TEXT NOT NULL,
  ${DatabaseColumnNames.timeCreated} TEXT NOT NULL
  )  
  ''');
  }

  Future closeDB() async {
    final db = await instance.database;

    db.close();
  }


  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(databaseTableName, note.toJson());

    return note.copyWith(id: id);
  }

  Future<Note> read(int id) async {
    final db = await instance.database;

    final mapOfNotes = await db.query(databaseTableName,
        columns: databaseQueryParameters,
        where: '${DatabaseColumnNames.id} = ?',
        whereArgs: [id]);

    if (mapOfNotes.isNotEmpty) {
      return Note.fromJson(mapOfNotes.first);
    } else {
      throw Exception('Note for ID not found');
    }
  }

  Future<List<Note>> readAll() async {
    final db = await instance.database;

    final notesMap = await db.query(databaseTableName,
        orderBy: '${DatabaseColumnNames.timeCreated} ASC');
    return notesMap.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return await db.update(
      databaseTableName,
      note.toJson(),
      where: '$DatabaseColumnNames.id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      databaseTableName,
      where: '$DatabaseColumnNames.id = ?',
      whereArgs: [id],
    );
  }
}
