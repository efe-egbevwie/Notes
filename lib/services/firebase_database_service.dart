import 'package:notes/database/firebase_storage.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/database.dart';

class FirebaseDatabaseService implements Database {
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase();

  @override
  Future createNote(Note note) async {
    return await _firebaseDatabase.createNote(note);
  }

  @override
  Future readNotes() async {
    return _firebaseDatabase.readNotes();
  }

  @override
  Future readNoteSingle(int id) async {
    return await _firebaseDatabase.readNoteSingle(id);
  }

  @override
  Future updateNote(Note note) async {
    return await _firebaseDatabase.updateNote(note);
  }

  @override
  Future deleteNote(int id) async {
    return await _firebaseDatabase.deleteNote(id);
  }
}
