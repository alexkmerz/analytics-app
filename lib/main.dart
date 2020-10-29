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
