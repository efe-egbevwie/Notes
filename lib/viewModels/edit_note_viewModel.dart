import 'package:flutter/widgets.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/database.dart';
import 'package:notes/services/navigation_service.dart';
import 'package:notes/viewModels/base_model.dart';

import '../service_locator.dart';

class EditNoteViewModel extends BaseModel {
  final formKey = GlobalKey<FormState>();

  var _firebaseDatabaseService = locator<Database>();
  var _navigationService = locator<NavigationService>();

  String title = '';
  String description = '';

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      timeCreated: DateTime.now(),
    );

    await _firebaseDatabaseService.createNote(note);
  }

  Future updateNote(Note note) async {
    final note = Note(
      title: title,
      description: description,
    );

    await _firebaseDatabaseService.updateNote(note);
  }

  void addOrUpdateNote(Note note) async {
    final isNoteValid = formKey.currentState.validate();

    if (isNoteValid) {
      final isUpdatingNote = note != null;
      if (isUpdatingNote) {
        await updateNote(note);
      } else {
        await addNote();
      }

      _navigationService.popUntil();
    }
  }
}
