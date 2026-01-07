import 'package:flutter/material.dart'; //Importe la bibliothèque Material Design de Flutter (widgets, thèmes, boutons, etc.).
import 'pages/login.dart';
import 'pages/forgot_password.dart';
import 'pages/prof.dart';
import 'pages/notes.dart';
import 'pages/admin.dart';


void main() {
  runApp(const SupComApp()); //Lance l'application Flutter et affiche le widget SupComApp comme racine de l’interface.
}

class SupComApp extends StatelessWidget { //l'application entière est définie comme un widget sans état (StatelessWidget).
  const SupComApp({super.key}); //Constructeur de la classe SupComApp.

  @override //Indique que la méthode build() remplace une méthode de la classe parente.
  Widget build(BuildContext context) { //Méthode build() qui décrit comment construire l'interface utilisateur de ce widget.
    return MaterialApp(//Utilise le widget MaterialApp pour configurer les paramètres globaux de l'application.
      debugShowCheckedModeBanner: false, //Désactive la bannière de débogage dans le coin supérieur droit de l'application.
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(), 
        '/forgotpass': (context) => ForgotPasswordPage(),
        '/prof': (context) => const ProfHomePage(),
        '/admin': (context) => const AdminHomePage(),
        '/notes': (context) => const PublierNotesPage(),
        
      },
    );             
  }
}
