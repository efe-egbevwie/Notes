import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/services/firebase_auth_service.dart';

import '../models/note.dart';

class FirebaseDatabase {
  FirebaseDatabase();



  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future createNote(Note note)  {
     return notesCollection
        .doc(AuthService.getUid())
        .collection(AuthService.getUid())
        .doc()
        .set(note.toJson())
        .catchError((error) => print('create note failed due to $error'));
  }

  Future readNoteSingle(int id) async {
    await notesCollection
        .doc(AuthService.getUid())
        .collection(AuthService.getUid())
        .doc()
        .get()
        .then((DocumentSnapshot snapshot) {
      return Note.fromJson(snapshot.data());
    });
  }

  Future updateNote(Note note)  {
    return notesCollection
        .doc(AuthService.getUid())
        .collection(AuthService.getUid())
        .where('_id', isEqualTo: note.id)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapShot) {
        documentSnapShot.reference.update(
          {
            'title': note.title,
            'description': note.description,
          },
        );
      });
    }).catchError((error) => print('update note failed due to $error'));
  }

  Future deleteNote(int id)  {
    return notesCollection
        .doc(AuthService.getUid())
        .collection(AuthService.getUid())
        .where('_id', isEqualTo: id)
        .get()
        .then((note) => note.docs.first.reference.delete())
        .catchError((error) => print('delete note failed due to $error'));
  }

  Stream<List<Note>> readNotes() {
    return notesCollection
        .doc(AuthService.getUid())
        .collection(AuthService.getUid())
        .orderBy('timeCreated', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((note) => Note(
              id: note.data()['_id'],
              title: note.data()['title'],
              description: note.data()['description'],
              timeCreated: DateTime.parse(note.data()['timeCreated'])))
          .toList();
    });
  }
}
