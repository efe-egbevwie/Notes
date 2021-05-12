import 'package:notes/models/note.dart';

abstract class Database{
  Future createNote(Note note);

  Future readNotes();

  Future readNoteSingle(int id);

  Future updateNote(Note note);

  Future deleteNote(int id);
}