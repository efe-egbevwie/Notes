import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/models/user.dart';
import 'package:notes/services/shared_prefs.dart';

import '../service_locator.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPrefs _prefs = locator<SharedPrefs>();

  String authErrorMessage;

  Future signUpWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _prefs.setSignedIn();
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          authErrorMessage =
              'Email already associated with an account. Sign in instead';
          break;
        case 'auth/invalid-email':
          authErrorMessage = 'Please enter a valid email';
          break;
        default:
          {
            authErrorMessage =
                'An error has occurred please review your credentials and try again';
          }
      }
    }
  }

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _prefs.setSignedIn();
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'user-not-found':
          authErrorMessage = 'Email not associated with an account';
          break;
        case 'wrong-password':
          authErrorMessage = 'Invalid password';
          break;
        default:
          {
            authErrorMessage =
                'An error has occurred please review your credentials and try again';
          }
      }
    } on SocketException catch (e) {
      print(e.toString());
      authErrorMessage = 'Your Internet Connection is unavailable';
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      _prefs.setSignedOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Stream<NoteUser> get userStateChanges {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  NoteUser _userFromFirebase(User user) {
    return user != null ? NoteUser(uid: user.uid) : null;
  }

   static String getUid() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    return uid;
  }
}
