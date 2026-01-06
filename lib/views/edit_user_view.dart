import 'package:flutter/material.dart';
import '../models/user_model.dart';

class EditUserView extends StatefulWidget {
  final AppUser user;

  const EditUserView({super.key, required this.user});

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  // Contrôleurs
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _detailsController;

  // Listes d'options (Les majuscules ici sont importantes pour l'affichage)
  final List<String> _roleOptions = ["Étudiant", "Professeur", "Administrateur"];
  final List<String> _statusOptions = ["Actif", "Suspendu", "En attente"];

  // Variables pour stocker la valeur sélectionnée (qui correspondra exactement à la liste)
  late String _selectedRole;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _detailsController = TextEditingController(text: widget.user.details);

    // --- CORRECTION DU BUG DE L'ÉCRAN ROUGE ---
    // On nettoie la valeur venant de la BDD pour qu'elle corresponde aux options du Dropdown
    _selectedRole = _validateValue(widget.user.role, _roleOptions);
    _selectedStatus = _validateValue(widget.user.status, _statusOptions);
  }

  // Fonction magique pour éviter le crash "There should be exactly one item..."
  String _validateValue(String valueFromDb, List<String> options) {
    // 1. Si la valeur existe exactement (ex: "Actif" == "Actif"), on la garde.
    if (options.contains(valueFromDb)) return valueFromDb;

    // 2. Sinon, on cherche une correspondance sans tenir compte des majuscules (ex: "actif" -> "Actif")
    try {
      return options.firstWhere(
        (option) => option.toLowerCase() == valueFromDb.toLowerCase(),
      );
    } catch (e) {
      // 3. Si vraiment rien ne correspond, on prend la première option par défaut pour ne pas planter
      return options.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinkHeader = const Color(0xFFE91E63);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Administration Profil", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {}, // Action supprimer à brancher
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 40,
              backgroundColor: pinkHeader,
              child: Text(
                widget.user.name.isNotEmpty ? widget.user.name[0].toUpperCase() : "?",
                style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Formulaire
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                children: [
                  _buildTextField("Nom complet", Icons.person, _nameController),
                  const SizedBox(height: 15),
                  _buildTextField("Email", Icons.email, _emailController),
                  const SizedBox(height: 15),
                  
                  // DROPDOWN RÔLE
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: _inputDecoration("Rôle", Icons.badge),
                    items: _roleOptions.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                    onChanged: (val) => setState(() => _selectedRole = val!),
                  ),
                  const SizedBox(height: 15),

                  _buildTextField("Détails (Classe/Dép.)", Icons.info_outline, _detailsController),
                  const SizedBox(height: 15),

                  // DROPDOWN STATUT
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: _inputDecoration("Statut", Icons.verified_user),
                    items: _statusOptions.map((status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(
                          status,
                          style: TextStyle(
                            color: status == "Actif" ? Colors.green : (status == "Suspendu" ? Colors.red : Colors.orange),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedStatus = val!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Bouton Sauvegarder
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Appeler votre ViewModel pour update ici
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Modifications enregistrées")));
                },
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text("ENREGISTRER", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(label, icon),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.orange),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    );
  }
}