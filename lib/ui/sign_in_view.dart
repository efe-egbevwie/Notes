import 'package:flutter/material.dart';
import 'package:notes/ui/sign_up_view.dart';
import 'package:notes/ui/widgets/roundButton.dart';
import 'package:notes/viewModels/sign_in_viewModel.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final signInViewModel = Provider.of<SignInViewModel>(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                            : RoundButton(
                                buttonText: 'Sign In',
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    signInViewModel.signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                        RoundButton(
                          buttonText: 'Sign Up',
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SignUpView()),
                              (route) => false,
                            );
                          },
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
