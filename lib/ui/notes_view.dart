import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/database/firebase_database.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/firebase_auth_service.dart';
import 'package:notes/services/navigation_service.dart';
import 'package:notes/ui/widgets/notesCard.dart';

import '../service_locator.dart';
import 'edit_note_view.dart';
import 'note_detail_view.dart';

class NotesView extends StatefulWidget {
  NotesView({
    Key key,
  }) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  var firebaseDatabase = locator<FirebaseDatabase>();
  var authService = locator<AuthService>();
  var navigationService = locator<NavigationService>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authService.signOut();
              }),
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
          )
        ],
        title: Center(
          child: Text(
            'Notes',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder<List<Note>>(
          stream: firebaseDatabase.readNotes(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor);
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Something went wrong, try again ',
                      style: TextStyle(color: Colors.black, fontSize: 30));
                } else {
                  if (snapshot.hasData) {
                    final notes = snapshot.data;
                    return showNotes(notes);
                  }
                  return Text(' No Notes',
                      style: TextStyle(color: Colors.black, fontSize: 30));
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          // color: Theme.of(context).accentColor,
        ),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditNoteView()));
        },
      ),
    );
  }

  Widget showNotes(
    List<Note> notes,
  ) {
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
              builder: (context) => NoteDetailView(
                note: note,
              ),
            ));
          },
          child: NotesCard(
            note: note,
            index: index,
            key: UniqueKey(),
          ),
        );
      },
    );
  }
}
