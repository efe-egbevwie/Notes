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
          IconButton(
            icon: Icon(Icons.save_outlined),
            onPressed: () {
              editNoteViewModel.addOrUpdateNote(widget.note);
            },
            iconSize: 30,
          ),
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

}
