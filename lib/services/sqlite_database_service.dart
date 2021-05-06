

import 'package:notes/database/db.dart';
import 'package:notes/database/notes.dart';

class SqliteDatabaseService {
  Future createNote(Note note) async {
    return await DB.instance.create(note);
  }

  Future readNotes() async {
    final notes = await DB.instance.readAll();
    return notes;
  }

  Future readNoteSingle(int id) async {
    final singleNote = await DB.instance.read(id);
    return singleNote;
  }

  Future updateNote(Note note) async {
    return await DB.instance.update(note);
  }

  Future deleteNote(int id) async {
    return await DB.instance.delete(id);
  }

  Future closeDatabase() async {
    return await DB.instance.closeDB();
  }
}
