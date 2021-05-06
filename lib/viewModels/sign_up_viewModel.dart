import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/constants.dart';
import 'package:notes/services/firebase_auth_service.dart';
import 'package:notes/services/navigation_service.dart';

import '../service_locator.dart';
import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthService _auth = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
    @required String email,
    @required String password,
  }) async {
    setLoading(true);

    var result = await _auth.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    setLoading(false);

    if (result != null) {
      _navigationService.pushReplacement(RouteNames.notesView);
    } else {
      _showErrorSnackBar(_auth.authErrorMessage);
    }
  }

  void _showErrorSnackBar(String message) {
    Get.snackbar('Error', message, backgroundColor: Colors.red);
  }
}
