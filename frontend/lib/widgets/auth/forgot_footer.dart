import 'package:flutter/material.dart';

class ForgotFooter extends StatelessWidget {
  const ForgotFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Besoin d'aide ?",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "Contactez le service scolarité ou le support technique",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),
        Text("scolarite@supcom.tn",
            style: TextStyle(color: Colors.blueAccent)),
        Text("+216 71 857 000",
            style: TextStyle(color: Colors.blueAccent)),
        SizedBox(height: 30),
        Text(
          "SUP'COM\nKEDUUX 2.1.1 © 2017-2025 2C Services\nTous droits réservés.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }
}
