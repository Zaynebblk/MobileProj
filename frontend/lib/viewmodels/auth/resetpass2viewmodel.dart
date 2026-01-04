import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordStep2ViewModel extends ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  // URL de ton backend (adapter selon émulateur / device)
  static const String baseUrl = "http://localhost:5000";

  Future<void> resetPassword(String email, String code) async {
    if (passwordController.text.isEmpty) {
      errorMessage = "Veuillez entrer un nouveau mot de passe";
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "code": code,
          "newPassword": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        successMessage = "Mot de passe mis à jour avec succès !";
        
      } else {
        final data = jsonDecode(response.body);
        errorMessage = data['message'] ?? "Erreur inconnue";
        
      }
    } catch (e) {
      errorMessage = "Erreur: ${e.toString()}";
      
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
