import 'package:cloud_firestore/cloud_firestore.dart';

import 'notes.dart';

class FirebaseDatabase {
  FirebaseDatabase({this.uid});

  final String uid;

  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future createNote(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc(note.hashCode.toString())
        .set(note.toJson())
        .catchError((error) => print('create note failed due to $error'));
  }

  Future readNoteSingle(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc(note.hashCode.toString())
        .get()
        .then((DocumentSnapshot snapshot) {
      return Note.fromJson(snapshot.data());
    });
  }

  Future updateNote(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc(note.hashCode.toString())
        .update(note.toJson())
        .catchError((error) => print('update note failed due to $error'));
  }

  Future deleteNote(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc(note.hashCode.toString())
        .delete()
        .catchError((error) => print('delete note failed due to $error'));
  }

  Future<List<Note>> getNotes() {
    var notes = notesCollection
        .doc(uid)
        .collection(uid)
        .snapshots()
        .map((noteSnapshot) => Note.fromJson(noteSnapshot.data()))
        .toList();
    return notes;
  }
}
