import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/login_viewmodel.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginViewModel>();

    return Column(
      children: [
        TextField(
          controller: vm.identifiantController,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Identifiant",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: vm.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Mot de passe",
            prefixIcon: Icon(Icons.lock),
          ),
        ),
      ],
    );
  }
}
