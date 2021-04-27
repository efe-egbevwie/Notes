import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/database/notes.dart';
import 'package:todolist/services/database_service.dart';

import '../service_locator.dart';

class NoteDetailScreen extends StatefulWidget {
  final int noteId;

  const NoteDetailScreen({
    @required this.noteId,
  });

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  Note note;
  bool isLoading = false;
  var databaseService = locator<DatabaseService>();

  @override
  void initState() {
    readNote();
    super.initState();
  }

  Future readNote() async {
    setState(() => isLoading = true);

    this.note = await databaseService.readNoteSingle(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
}
