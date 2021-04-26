import 'package:todolist/database/db.dart';
import 'package:todolist/database/notes.dart';

class DatabaseService{

  Future createNote(Note note) async{
    return await DB.instance.create(note);
  }

  Future readNotes() async {
    final notes = await DB.instance.readAll();
    return notes;
  }

  Future updateNote(Note note) async {
    return await DB.instance.update(note);
  }

  Future deleteNote(int id) async{
    return await DB.instance.delete(id);
  }

  Future closeDatabase() async{
    return await DB.instance.closeDB();
  }
}