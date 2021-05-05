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
        .doc()
        .set(note.toJson())
        .catchError((error) => print('create note failed due to $error'));
  }

  Future readNoteSingle(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc()
        .get()
        .then((DocumentSnapshot snapshot) {
      return Note.fromJson(snapshot.data());
    });
  }

  Future updateNote(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc()
        .update(note.toJson())
        .catchError((error) => print('update note failed due to $error'));
  }

  Future deleteNote(Note note) async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .doc()
        .delete()
        .catchError((error) => print('delete note failed due to $error'));
  }

  Future<List<Note>> getNotes() async {
    await notesCollection
        .doc(uid)
        .collection(uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((note) {
        return Note.fromJson(note.data());
      });
    });
  }
}
