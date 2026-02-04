import 'package:flutter/material.dart';
// Import your Login/Signup screens here once created

class AuthRoutes {
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const Scaffold(body: Center(child: Text("Login Screen"))),
      signup: (context) => const Scaffold(body: Center(child: Text("Signup Screen"))),
    };
  }
}