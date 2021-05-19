import 'package:flutter/material.dart';
import 'package:notes/services/auth_state.dart';
import 'package:notes/ui/notes_view.dart';
import 'package:notes/ui/sign_in_view.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AuthenticationWrapper extends StatefulWidget {
  AuthenticationWrapper(this._authState);

  final AuthState _authState;

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<bool>(
        preference: widget._authState.authState,
        builder: (context, snapshot) {
          if (snapshot == false) {
            return SignInVIew();
          } else {
            return NotesView();
          }
        });
  }
}
