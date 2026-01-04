import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/forgot_password_viewmodel.dart';

class ForgotForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<ForgotPasswordViewModel>();

    return TextField(
      controller: vm.emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E2A3B),
        hintText: "Email ou Identifiant",
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.email, color: Colors.white54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
