import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/models/user.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String authErrorMessage;

  Future signUpWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'auth/email-already-exists':
          authErrorMessage = 'Email already associated with an account';
          break;
        case 'auth/invalid-email':
          authErrorMessage = 'Please enter a valid email';
          break;
        case 'auth/invalid-password':
          authErrorMessage = 'Invalid password';
          break;
        default:
          {
            authErrorMessage = 'An error has occurred please try again';
          }
      }
    }
  }

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'auth/invalid-email':
          authErrorMessage = 'Email not associated with an account';
          break;
        case 'auth/invalid-password':
          authErrorMessage = 'Invalid password';
          break;
        default:
          {
            authErrorMessage = 'An error has occurred please try again';
          }
      }
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
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
