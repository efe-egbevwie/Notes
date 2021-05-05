import 'package:flutter/material.dart';
import 'package:notes/models/user.dart';
import 'package:notes/screens/notes_screen.dart';
import 'package:notes/screens/sign_up_screen.dart';
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
      return SignUpScreen();
    } else {
      return NotesScreen();
    }
  }
}
