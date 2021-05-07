import 'package:flutter/material.dart';
import 'package:notes/constants.dart';
import 'package:notes/services/navigation_service.dart';
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
      body: Center(
        child: Container(
          height: size.height * 0.6,
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
                          style: TextStyle(
                              fontSize: 23,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(29)),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Please enter an email' : null,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.visibility_sharp),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29))),
                          obscureText: obscurePassword,
                          validator: (val) => val.length < 6
                              ? 'Please input a password with 6 or more characters'
                              : null,
                          controller: passwordController,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        signInViewModel.isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.blue)
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    minimumSize: Size(size.width * 0.8, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();

                                    signInViewModel.signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                                child: Text('Sign in'),
                              ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).accentColor,
                            minimumSize: Size(size.width * 0.5, 50.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            _navigationService
                                .pushReplacement(RouteNames.signUpView);
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
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
