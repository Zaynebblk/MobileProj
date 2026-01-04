import 'package:flutter/material.dart';

class ForgotInfoBox extends StatelessWidget {
  const ForgotInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A3B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.yellow),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Vous recevrez un email avec un lien pour réinitialiser votre mot de passe. Le lien sera valide pendant 24 heures.",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
