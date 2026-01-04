import 'package:flutter/material.dart';
import '../../views/auth/forgot_password.dart';

class LoginFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Se connecter", style: TextStyle(color: Colors.white)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ForgotPasswordPage()),
                );
              },
              child: const Text(
                "Mot de passe oublié",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "SUP'COM\nKEDUX 2.1.1 © 2017-2025 2C Services\nTous droits réservés.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}
