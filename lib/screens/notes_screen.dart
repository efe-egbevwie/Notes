import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todolist/database/notes.dart';
import 'package:todolist/screens/edit_note_screen.dart';
import 'package:todolist/screens/note_detail_screen.dart';
import 'package:todolist/service_locator.dart';
import 'package:todolist/services/database_service.dart';
import 'package:todolist/widgets/notesCard.dart';

class NotesScreen extends StatefulWidget {

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes;
  bool isLoading = false;
  var databaseService = locator<DatabaseService>();


  @override
  void initState() {
    super.initState();
    readNotes();
  }



  @override
  void dispose() {
    super.dispose();

  }

  @override
  void deactivate(){
    super.deactivate();
    //databaseService.closeDatabase();
  }

  Future readNotes() async {
    setState(() => isLoading = true);

    notes = await databaseService.readNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Notes',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : notes.isEmpty
                ? Text(
                    ' No Notes',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                : showNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditNoteScreen()));
          readNotes();
        },
      ),
    );
  }



  Widget showNotes() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      itemCount: notes.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final note = notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailScreen(noteId: note.id,),
            ));
            readNotes();
          },
          child: NotesCard(note: note, index: index),
        );
      },
    );
  }
}
