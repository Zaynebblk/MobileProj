import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/resetpass2viewmodel.dart';
import '../../views/auth/login.dart';

class ResetPasswordStep2View extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordStep2View({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordStep2View> createState() => _ResetPasswordStep2ViewState();
}

class _ResetPasswordStep2ViewState extends State<ResetPasswordStep2View> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordStep2ViewModel(),
      child: Consumer<ResetPasswordStep2ViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Réinitialiser le mot de passe"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: vm.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Nouveau mot de passe",
                      hintText: "Entrez votre nouveau mot de passe",
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            await vm.resetPassword(widget.email, widget.code);

                            // Affichage des messages avec SnackBar
                            if (vm.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(vm.errorMessage!),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                              vm.errorMessage = null; // reset pour éviter répétition
                            }

                            if (vm.successMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(vm.successMessage!),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );

                              // Attendre 1 seconde avant de naviguer vers Login
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginPage()),
                                );
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: vm.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Changer le mot de passe",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
