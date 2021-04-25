import 'package:flutter/material.dart';
import 'package:todolist/database/notes.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future readNotes() async{

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes',
        style: TextStyle(fontSize: 25),

        ),
      ),
    );
  }
}
