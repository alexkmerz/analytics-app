library analytics.auth;

import 'package:http/http.dart' as http;
import 'dart:convert';

import './globals.dart' as globals;

///
/// Credentials used for login and register
///
class Credentials {
  final String email;
  final String password;

  Credentials(this.email, this.password);
}

///
/// Authenticate against the analytics api
///
Future<bool> attemptLogin(Credentials credentials) async {
  final response = await http.post('${globals.url}/auth/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'email': credentials.email,
        'password': credentials.password
      }));

  if (response.statusCode == 200) {
    globals.jwt = response.body;
    return true;
  } else {
    throw Exception('Failed to authenticate');
  }
}

///
/// Register with the analytics api
///
Future<bool> attemptRegister(Credentials credentials) async {
  final response = await http.post('${globals.url}/auth/register',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF=8'
      },
      body: jsonEncode(<String, String>{
        'email': credentials.email,
        'password': credentials.password
      }));

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to register');
  }
}
