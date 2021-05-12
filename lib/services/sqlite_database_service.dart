import 'package:notes/database/sqlite_database.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/database.dart';

class SqliteDatabaseService implements Database {
  @override
  Future createNote(Note note) async {
    return await SqliteDatabase.instance.create(note);
  }

  @override
  Future readNotes() async {
    final notes = await SqliteDatabase.instance.readAll();
    return notes;
  }

  @override
  Future readNoteSingle(int id) async {
    final singleNote = await SqliteDatabase.instance.read(id);
    return singleNote;
  }

  @override
  Future updateNote(Note note) async {
    return await SqliteDatabase.instance.update(note);
  }

  @override
  Future deleteNote(int id) async {
    return await SqliteDatabase.instance.delete(id);
  }

  Future closeDatabase() async {
    return await SqliteDatabase.instance.closeDB();
  }
}
