import 'package:flutter/material.dart';
import 'package:notes/constants.dart';
import 'package:notes/services/navigation_service.dart';
import 'package:notes/ui/widgets/custom_text_field.dart';
import 'package:notes/ui/widgets/roundButton.dart';
import 'package:notes/viewModels/sign_in_viewModel.dart';
import 'package:provider/provider.dart';

import '../service_locator.dart';

class SignInVIew extends StatefulWidget {
  const SignInVIew();

  @override
  _SignInVIewState createState() => _SignInVIewState();
}

class _SignInVIewState extends State<SignInVIew> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInViewModel = Provider.of<SignInViewModel>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          height: size.height * 0.7,
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(fontSize: 35, color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Email',
                          textColor: Colors.black,
                          borderColor: Theme.of(context).primaryColor,
                          validator: (val) => val.isEmpty ? 'Please enter an email' : null,
                          controller: emailController,
                          textCapitalization: TextCapitalization.none,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          hintText: 'Password',
                          textColor: Colors.black,
                          obscureText: obscurePassword,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility_sharp),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          borderColor: Theme.of(context).primaryColor,
                          validator: (val) =>
                              val.length < 6 ? 'Please input a password with 6 or more characters' : null,
                          controller: passwordController,
                          textCapitalization: TextCapitalization.none,
                        ),
                        SizedBox(height: 30),
                        signInViewModel.isLoading
                            ? CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor)
                            : CustomRoundButton(
                                buttonText: 'Sign in',
                                size: Size(size.width * 0.8, 50),
                                buttonColor: Theme.of(context).primaryColor,
                                borderColor: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();

                                    signInViewModel.signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                        SizedBox(height: 12),
                        CustomRoundButton(
                          buttonText: 'Sign up',
                          size: Size(size.width * 0.5, 50),
                          buttonColor: Theme.of(context).accentColor,
                          borderColor: Theme.of(context).accentColor,
                          onPressed: () {
                            _navigationService.pushReplacement(RouteNames.signUpView);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
