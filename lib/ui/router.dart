import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/ui/edit_note_view.dart';
import 'package:notes/ui/note_detail_view.dart';
import 'package:notes/ui/notes_view.dart';
import 'package:notes/ui/sign_in_view.dart';
import 'package:notes/ui/sign_up_view.dart';

import '../constants.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.notesView:
        return _materialPageRoute(
          routeName: settings.name,
          viewToShow: NotesView(),
        );

      case RouteNames.editNoteView:
        return _materialPageRoute(
          routeName: settings.name,
          viewToShow: EditNoteView(),
        );

      case RouteNames.noteDetailView:
        return _materialPageRoute(
          routeName: settings.name,
          viewToShow: NoteDetailView(
            noteId: settings.arguments,
          ),
        );

      case RouteNames.signInView:
        return _materialPageRoute(
          routeName: settings.name,
          viewToShow: SignInVIew(),
        );

      case RouteNames.signUpView:
        return _materialPageRoute(
          routeName: settings.name,
          viewToShow: SignUpView(),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

PageRoute _materialPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
