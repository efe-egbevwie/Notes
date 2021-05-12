import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/ui/widgets/notesForm.dart';
import 'package:notes/viewModels/edit_note_viewModel.dart';

import '../service_locator.dart';

class EditNoteView extends StatefulWidget {
  final Note note;

  const EditNoteView({this.note});

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  var editNoteViewModel = locator<EditNoteViewModel>();

  @override
  void initState() {
    super.initState();
    editNoteViewModel.title = widget.note?.title ?? '';
    editNoteViewModel.description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          saveButton(() {
            print(editNoteViewModel.title);
            editNoteViewModel.addOrUpdateNote(widget.note);
          })
        ],
      ),
      body: Form(
        key: editNoteViewModel.formKey,
        child: NotesForm(
          title: editNoteViewModel.title,
          description: editNoteViewModel.description,
          onTitleChanged: (title) =>
              setState(() => editNoteViewModel.title = title),
          onDescriptionChanged: (description) =>
              setState(() => editNoteViewModel.description = description),
        ),
      ),
    );
  }

  Widget saveButton(Function onPressed) {
    final isFormValid = editNoteViewModel.title.isNotEmpty && editNoteViewModel.description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: isFormValid ? null : Colors.grey),
          child: Text('Save'),
          onPressed: onPressed),
    );
  }


}
