import 'package:flutter/material.dart';

import 'package:analytics/services/globals.dart' as globals;

import 'views/home.dart';
import 'views/login.dart';
import 'views/register.dart';

void main() => runApp(AnalyticsRouter());

class AnalyticsRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: (globals.jwt == null) ? "/login" : "/",
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage()
      },
    );
  }
}

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// class RegisterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final appTitle = 'Form Validation Demo';

//     return MaterialApp(
//       title: appTitle,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(appTitle),
//         ),
//         body: LoginForm(),
//       ),
//     );
//   }
// }

// // Create a Form widget.
// class LoginForm extends StatefulWidget {
//   @override
//   LoginFormState createState() {
//     return LoginFormState();
//   }
// }

// class JWT {
//   final String token;
//   final String expiry;

//   JWT({this.token, this.expiry});

//   factory JWT.fromJson(Map<String, dynamic> json) {
//     return JWT(token: json['token'], expiry: json['expiry']);
//   }
// }

// class Credentials {
//   final String email;
//   final String password;

//   Credentials(this.email, this.password);
// }

// class LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();

//   String jwt;

//   Future<String> login(credentials) async {
//     final response = await http.post('http://localhost:4000/auth/login',
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(<String, String>{
//           'email': credentials.email,
//           'password': credentials.password
//         }));

//     if (response.statusCode == 200) {
//       jwt = response.body;
//       return null;
//     } else {
//       throw Exception('Failed to authenticate');
//     }
//   }

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please your email';
//                 }
//                 return null;
//               },
//               controller: emailController),
//           TextFormField(
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 return null;
//               },
//               controller: passwordController),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState.validate()) {
//                   Credentials credentials = new Credentials(
//                       emailController.text, passwordController.text);

//                   login(credentials);
//                 }
//               },
//               child: Text('Login'),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
