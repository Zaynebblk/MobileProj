import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/user_view_model.dart'; // Assurez-vous que l'import est correct
import '../models/user_model.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  // État local
  String _selectedRole = "Étudiant";
  bool _isLoading = false;
  bool _obscurePassword = true;

  final List<String> _roleOptions = ["Étudiant", "Professeur", "Administrateur"];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // Fonction pour soumettre le formulaire
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulation d'attente (ou appel API réel via ViewModel)
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      // TODO: Décommentez ceci quand votre ViewModel aura la méthode addUser
      /*
      Provider.of<UserViewModel>(context, listen: false).addUser(
        AppUser(
          id: DateTime.now().toString(), // ID temporaire
          name: _nameController.text,
          email: _emailController.text,
          role: _selectedRole,
          status: "Actif", // Par défaut
          details: _detailsController.text,
        )
      );
      */

      setState(() => _isLoading = false);
      
      // Feedback et retour
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Utilisateur créé avec succès !"), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pinkHeader = const Color(0xFFE91E63);
    final orangeBtn = const Color(0xFFE65100);
    final creamBg = const Color(0xFFFFF8E1);

    // Label dynamique selon le rôle
    String detailsLabel = "Classe (ex: 2A-RT)";
    if (_selectedRole == "Professeur") detailsLabel = "Département (ex: Informatique)";
    if (_selectedRole == "Administrateur") detailsLabel = "Poste / Service";

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Nouvel Utilisateur", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Icône Header
              Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: pinkHeader.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_add, size: 50, color: pinkHeader),
                ),
              ),
              const SizedBox(height: 25),

              // CARTE FORMULAIRE
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Identifiants", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.brown)),
                    const SizedBox(height: 15),

                    // Nom
                    _buildTextFormField(
                      controller: _nameController,
                      label: "Nom complet",
                      icon: Icons.person,
                      validator: (v) => v!.isEmpty ? "Le nom est requis" : null,
                    ),
                    const SizedBox(height: 15),

                    // Email
                    _buildTextFormField(
                      controller: _emailController,
                      label: "Email universitaire",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.contains("@") ? null : "Email invalide",
                    ),
                    const SizedBox(height: 15),

                    // Mot de passe
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Mot de passe provisoire",
                        prefixIcon: const Icon(Icons.lock, color: Colors.orange),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                      validator: (v) => v!.length < 6 ? "Minimum 6 caractères" : null,
                    ),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(),
                    ),

                    const Text("Rôle & Affectation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.brown)),
                    const SizedBox(height: 15),

                    // Dropdown Rôle
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: InputDecoration(
                        labelText: "Rôle",
                        prefixIcon: const Icon(Icons.badge, color: Colors.orange),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      ),
                      items: _roleOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                      onChanged: (val) => setState(() => _selectedRole = val!),
                    ),
                    const SizedBox(height: 15),

                    // Détails dynamiques
                    _buildTextFormField(
                      controller: _detailsController,
                      label: detailsLabel,
                      icon: _selectedRole == "Étudiant" ? Icons.class_ : Icons.business,
                      validator: (v) => v!.isEmpty ? "Ce champ est requis" : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // BOUTON CRÉER
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeBtn,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text("CRÉER L'UTILISATEUR", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.orange)),
      ),
    );
  }
}