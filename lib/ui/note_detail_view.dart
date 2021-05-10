import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/sql_note.dart';
import 'package:notes/services/sqlite_database_service.dart';

import '../service_locator.dart';
import 'edit_note_view.dart';
import 'notes_view.dart';

class NoteDetailView extends StatefulWidget {
  final int noteId;

  const NoteDetailView({
    @required this.noteId,
  });

  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  Note note;
  bool isLoading = false;
  var databaseService = locator<SqliteDatabaseService>();

  @override
  void initState() {
    readNote();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future readNote() async {
    setState(() => isLoading = true);

    this.note = await databaseService.readNoteSingle(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          editButton(),
          deleteButton(),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  SelectableText(
                    note.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(height: 25),
                  Text(
                    DateFormat.yMMMd().format(note.timeCreated),
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 25),
                  SelectableText(
                    note.description,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                  )
                ],
              ),
            ),
    );
  }

  Widget editButton() {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditNoteView(
                  note: note,
                )));

        readNote();
      },
    );
  }

  Widget deleteButton() {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        _showDeleteNoteDialog();
      },
    );
  }

  void _showDeleteNoteDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete note?'),
            content: Text('Are you sure you want to delete this note?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              TextButton(
                  onPressed: () async {
                    await databaseService.deleteNote(note.id);
                    //Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => NotesView()),
                        (route) => false);
                  },
                  child: Text('Yes')),
            ],
          );
        });
  }
}
