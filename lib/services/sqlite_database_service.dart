import 'package:notes/database/db.dart';
import 'package:notes/models/sql_note.dart';
import 'package:notes/services/database.dart';

class SqliteDatabaseService implements Database {
  @override
  Future createNote(Note note) async {
    return await DB.instance.create(note);
  }

  @override
  Future readNotes() async {
    final notes = await DB.instance.readAll();
    return notes;
  }

  @override
  Future readNoteSingle(int id) async {
    final singleNote = await DB.instance.read(id);
    return singleNote;
  }

  @override
  Future updateNote(Note note) async {
    return await DB.instance.update(note);
  }

  @override
  Future deleteNote(int id) async {
    return await DB.instance.delete(id);
  }

  Future closeDatabase() async {
    return await DB.instance.closeDB();
  }
}
