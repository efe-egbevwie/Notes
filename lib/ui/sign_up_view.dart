import 'package:flutter/material.dart';
import 'package:notes/ui/sign_in_view.dart';
import 'package:notes/ui/widgets/roundButton.dart';
import 'package:notes/viewModels/sign_up_viewModel.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView();

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context);
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
                        signUpViewModel.isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              )
                            : RoundButton(
                                buttonText: 'Sign Up',
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();

                                    signUpViewModel.signUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                              ),
                        RoundButton(
                          buttonText: 'Sign In',
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SignInVIew()),
                                (route) => false);
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
