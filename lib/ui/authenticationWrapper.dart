import 'package:flutter/material.dart';
import 'package:notes/models/user.dart';
import 'package:notes/ui/notes_view.dart';
import 'package:notes/ui/sign_in_view.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<NoteUser>(context);
    if (userState == null) {
      return SignInVIew();
    } else {
      return NotesView();
    }
  }
}
