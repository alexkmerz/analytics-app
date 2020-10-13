import 'package:flutter/material.dart';

import 'package:analytics/services/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  _formKey.currentState.validate();

                  Credentials credentials = new Credentials(
                      emailController.text, passwordController.text);

                  attemptLogin(credentials).then((bool success) {
                    debugPrint('Login successful: ${success.toString()}');
                  });
                },
              ),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
