import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<String> submit() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      throw Exception("Veuillez entrer votre email");
    }

    isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.forgotPassword(email);

      if (result["success"] != true) {
        throw Exception(result["message"]);
      }

      return "Lien de réinitialisation envoyé";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
