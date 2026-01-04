import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../../views/auth/resetpass2.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future<void> verifyOtp(BuildContext context, String email) async {
    final code = otpController.text.trim();

    debugPrint('🔍 verifyOtp called with email: "$email" (length: ${email.length})');
    debugPrint('🔍 Code: "$code"');

    if (code.isEmpty) {
      errorMessage = "Veuillez entrer le code";
      notifyListeners();
      return;
    }

    if (email.isEmpty) {
      errorMessage = "Email is missing";
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Verify the reset code with the backend
      final response = await ApiService.verifyResetCode(email, code);

      if (response['success'] == true) {
        // Code is valid, navigate to the next step
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordStep2View(
              email: email,
              code: code,
            ),
          ),
        );
      } else {
        // Code verification failed
        errorMessage = response['message'] ?? "Code invalide ou expiré";
      }
    } catch (e) {
      errorMessage = "Erreur lors de la vérification: ${e.toString()}";
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}

 

