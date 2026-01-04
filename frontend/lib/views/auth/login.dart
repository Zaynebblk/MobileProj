import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth/login_viewmodel.dart';
import '../../widgets/auth/role_selector.dart';
import '../../widgets/auth/login_form.dart';
import '../../widgets/auth/login_footer.dart';

import '../prof/prof.dart';
import '../admin/admin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 39, 61),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 380,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Image.asset("assets/imgs/logo.png", width: 240),
                const SizedBox(height: 20),

                const Text(
                  "Veuillez saisir votre login et mot de passe",
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),
                RoleSelector(
                  selectedIndex: vm.selectedRole,
                  onChanged: vm.selectRole,
                ),

                const SizedBox(height: 20),
                LoginForm(),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            try {
                              final result = await vm.login();

                              if (result.containsKey('token')) {
                                if (vm.selectedRole == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const ProfHomePage()),
                                  );
                                } else if (vm.selectedRole == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const AdminHomePage()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Page étudiant non définie")),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(result['error'] ??
                                          "Erreur de connexion")),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                    child: vm.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Se connecter"),
                  ),
                ),

                const SizedBox(height: 12),
                LoginFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
