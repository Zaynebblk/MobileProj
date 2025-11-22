import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/forgot_password.dart';


void main() {
  runApp(const SupComApp());
}

class SupComApp extends StatelessWidget {
  const SupComApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        '/forgotpass': (context) => ForgotPasswordPage(),
        
      },
    );             
  }
}
