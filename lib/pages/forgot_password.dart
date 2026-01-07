import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Retour à la connexion", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Logo
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), 
                  child: Image.asset(
                    "assets/imgs/logo.png",
                    width: 240,
                  ),
                ),
              ),


              const SizedBox(height: 30),

              const Center(
                child: Text(
                  "Mot de passe oublié",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Entrez votre adresse email ou identifiant pour recevoir un lien de réinitialisation",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1E2A3B),
                  hintText: "Email ou Identifiant",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.white54),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF337BFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Envoyer le lien de réinitialisation",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2A3B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.yellow, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Vous recevrez un email avec un lien pour réinitialiser votre mot de passe. Le lien sera valide pendant 24 heures.",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Center(
                child: Text(
                  "Besoin d'aide ?",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              const Center(
                child: Column(
                  children: [
                    Text("Contactez le service scolarité ou le support technique", style: TextStyle(color: Colors.white70, fontSize: 13)),
                    SizedBox(height: 6),
                    Text("scolarite@supcom.tn", style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
                    Text("+216 71 857 000", style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Center(
                child: Text(
                  "SUP'COM\nKEDUUX 2.1.1 © 2017-2025 2C Services\nTous droits réservés.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
