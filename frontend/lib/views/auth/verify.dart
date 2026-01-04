import 'package:flutter/material.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vérification")),
      body: const Center(
        child: Text(
          "Veuillez vérifier votre email pour le lien de réinitialisation",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
