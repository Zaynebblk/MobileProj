import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'prof.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int selectedTab = 0;
  final identifiantController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 39, 61),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withValues(alpha: 0.05),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), 
                  child: Image.asset(
                    "assets/imgs/logo.png",
                    width: 240,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Veuillez saisir votre login et mot de passe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    roleButton("Étudiant", 0),
                    roleButton("Professeur", 1),
                    roleButton("Administrateur", 2),
                  ],
                ),

                const SizedBox(height: 20),

                
                TextField(
                  controller: identifiantController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Identifiant",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Mot de passe",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4062C0),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                    
                      if (selectedTab == 1) {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfHomePage(),
                          ),
                        );
                      } else if (selectedTab == 0) {
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Page etudiant non définie")),
                        );
                      } else if (selectedTab == 2) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Page Administrateur non définie")),
                        );
                      }
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 12),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Se connecter",
                      style: TextStyle(color: Colors.white),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
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
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget roleButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: selectedTab == index
                ? Colors.white
                : Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedTab == index ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
