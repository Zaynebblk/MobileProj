import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/reset_password_viewmodel.dart';
import '../../widgets/auth/otp_input.dart';
import '../../widgets/auth/primary_button.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;

   ResetPasswordView({
    super.key,
    this.email = "",
  }) {
    debugPrint('🎯 ResetPasswordView constructor called with email: "$email"');
  }

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  void initState() {
    super.initState();
    debugPrint('📧 ResetPasswordView initialized with email: "${widget.email}" (length: ${widget.email.length})');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B2A41), Color(0xFF0F172A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Consumer<ResetPasswordViewModel>(
                builder: (context, vm, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Retour à la connexion",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Logo
                      Image.asset(
                        "assets/imgs/logo.png",
                        height: 80,
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Vérification du code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Entrez le code reçu par email",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 30),

                      OtpInput(controller: vm.otpController),

                      if (vm.errorMessage != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          vm.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ],

                      const SizedBox(height: 20),

                      PrimaryButton(
                        text: "Vérifier le code",
                        isLoading: vm.isLoading,
                        onPressed: () => vm.verifyOtp(context, widget.email),
                      ),

                      const Spacer(),

                      const Text(
                        "SUPCOM © 2017–2025",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
