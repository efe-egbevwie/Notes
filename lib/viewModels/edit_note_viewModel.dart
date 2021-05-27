import 'package:flutter/widgets.dart';
import 'package:notes/database/firebase_database.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/navigation_service.dart';
import 'package:notes/viewModels/base_model.dart';

import '../service_locator.dart';

class EditNoteViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();

  var _firebaseDatabaseService = locator<FirebaseDatabase>();
  var _navigationService = locator<NavigationService>();

  String title = '';
  String description = '';

  Future addNote()  {
    final note = Note(
      title: title,
      description: description,
      timeCreated: DateTime.now(),
    );

    return _firebaseDatabaseService.createNote(note);
  }

  Future updateNote(Note note)  {
     note = Note(
       id: note.id,
      title: title,
      description: description,
    );

    return _firebaseDatabaseService.updateNote(note);
  }

  void addOrUpdateNote(Note note)  {
    final isNoteValid = formKey.currentState.validate();

    if (isNoteValid) {
      final isUpdatingNote = note != null;
      if (isUpdatingNote) {
         updateNote(note);
      } else {
         addNote();
      }

      _navigationService.popUntil();
    }
  }
}
