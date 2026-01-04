import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth/forgot_password_viewmodel.dart';
import '../../widgets/auth/forgot_form.dart';
import '../../widgets/auth/forgot_info_box.dart';
import '../../widgets/auth/forgot_footer.dart';
import 'resetpass1.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: const _ForgotView(),
    );
  }
}

class _ForgotView extends StatelessWidget {
  const _ForgotView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ForgotPasswordViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF0F1C2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1C2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset("assets/imgs/logo.png", width: 240),
            const SizedBox(height: 30),

            const Text(
              "Mot de passe oublié",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),
            const Text(
              "Entrez votre adresse email ou identifiant pour recevoir un lien de réinitialisation",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            ForgotForm(),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: vm.isLoading
                    ? null
                    : () async {
                        try {
                          debugPrint('🔐 Button pressed');
                          debugPrint('📧 Email in controller: "${vm.emailController.text}"');
                          
                          final message = await vm.submit();
                          
                          debugPrint('✅ Submit successful');
                          debugPrint('📧 Email after submit: "${vm.emailController.text}"');
                          
                          // Save email before clearing
                          final email = vm.emailController.text.trim();
                          debugPrint('💾 Saved email: "$email"');

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );

                          // Navigate to reset password page with email
                          debugPrint('🚀 Navigating with email: "$email"');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResetPasswordView(
                                email: email,
                              ),
                            ),
                          );

                          vm.emailController.clear();
                          debugPrint('🗑️ Email cleared');
                        } catch (e) {
                          debugPrint('❌ Error: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },

                child: vm.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Envoyer le lien de réinitialisation"),
              ),
            ),

            const SizedBox(height: 20),
            const ForgotInfoBox(),
            const SizedBox(height: 40),
            const ForgotFooter(),
          ],
        ),
      ),
    );
  }
}
