import 'package:flutter/material.dart';
import 'package:notes/database/firebase_storage.dart';
import 'package:notes/models/sql_note.dart';
import 'package:notes/services/sqlite_database_service.dart';
import 'package:notes/ui/widgets/notesForm.dart';


import '../service_locator.dart';

class EditNoteView extends StatefulWidget {
  final Note note;

  const EditNoteView({this.note});

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  var sqlDatabaseService = locator<SqliteDatabaseService>();
  var firebaseDatabaseService = locator<FirebaseDatabase>();
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [saveButton()],
      ),
      body: Form(
        key: _formKey,
        child: NotesForm(
          title: title,
          description: description,
          onTitleChanged: (title) => setState(() => this.title = title),
          onDescriptionChanged: (description) => setState(() => this.description = description),
        ),
      ),
    );
  }

  Widget saveButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: isFormValid ? null : Colors.grey
        ),
        child: Text('Save'),
        onPressed: () {
          print('this is the title: $title');
          print('this is the description: $description');
          addOrUpdateNote();
        },
      ),
    );
  }

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      timeCreated: DateTime.now(),
    );

    await firebaseDatabaseService.createNote(note);
  }

  Future updateNote() async {
    final note = widget.note?.copyWith(
      title: title,
      description: description,
    );

    await sqlDatabaseService.updateNote(note);
  }

  void addOrUpdateNote() async{
    final isNoteValid = _formKey.currentState.validate();

    if(isNoteValid) {
      final isUpdatingNote = widget.note != null;
      if(isUpdatingNote) {
        await updateNote();
      } else{
        await addNote();
      }

      Navigator.of(context).pop();
    }

  }
}
