import 'package:flutter/material.dart';

class AddSubjectView extends StatefulWidget {
  const AddSubjectView({super.key});

  @override
  State<AddSubjectView> createState() => _AddSubjectViewState();
}

class _AddSubjectViewState extends State<AddSubjectView> {
  final _formKey = GlobalKey<FormState>();
  
  // Couleurs (Identiques à votre thème)
  final pinkHeader = const Color(0xFFE91E63);
  final orangeBtn = const Color(0xFFE65100);
  final creamBg = const Color(0xFFFFF8E1);

  // Contrôleurs
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _profController = TextEditingController();
  final _coeffController = TextEditingController();

  // Valeurs par défaut pour les listes déroulantes
  String _selectedSemester = "Semestre 1";
  String _selectedType = "Cours Magistral";
  
  final List<String> _semesters = ["Semestre 1", "Semestre 2", "Annuel"];
  final List<String> _types = ["Cours Magistral", "Travaux Dirigés (TD)", "Travaux Pratiques (TP)", "Atelier", "Projet"];

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _profController.dispose();
    _coeffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Nouvelle Matière", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Informations Générales"),
              const SizedBox(height: 15),
              
              _buildTextField("Nom de la matière", "Ex: Algèbre Linéaire", _nameController, Icons.menu_book),
              const SizedBox(height: 15),
              
              Row(
                children: [
                  Expanded(child: _buildTextField("Code", "Ex: MATH101", _codeController, Icons.qr_code)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField(
                      "Coefficient", 
                      "Ex: 3.0", 
                      _coeffController, 
                      Icons.percent, 
                      isNumber: true
                    )
                  ),
                ],
              ),
              
              const SizedBox(height: 25),
              _sectionTitle("Détails Académiques"),
              const SizedBox(height: 15),

              _buildDropdown("Semestre", _selectedSemester, _semesters, (val) => setState(() => _selectedSemester = val!)),
              const SizedBox(height: 15),
              _buildDropdown("Type d'enseignement", _selectedType, _types, (val) => setState(() => _selectedType = val!)),
              
              const SizedBox(height: 15),
              _buildTextField("Professeur Responsable", "Ex: Mr. Ben Salah", _profController, Icons.person),

              const SizedBox(height: 40),

              // BOUTON DE SOUMISSION
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulation d'enregistrement
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Matière ajoutée avec succès !"),
                          backgroundColor: Colors.green,
                        )
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeBtn,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                  child: const Text("ENREGISTRER LA MATIÈRE", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title, 
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, IconData icon, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      validator: (value) => value == null || value.isEmpty ? "Champ requis" : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}