import 'package:flutter/material.dart';

class AddAnnouncementView extends StatefulWidget {
  const AddAnnouncementView({super.key});

  @override
  State<AddAnnouncementView> createState() => _AddAnnouncementViewState();
}

class _AddAnnouncementViewState extends State<AddAnnouncementView> {
  final _formKey = GlobalKey<FormState>();

  // Couleurs du thème
  final pinkHeader = const Color(0xFFE91E63);
  final orangeBtn = const Color(0xFFE65100);
  final creamBg = const Color(0xFFFFF8E1);

  // Contrôleurs
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // Valeurs par défaut
  String _selectedAudience = "Tous les utilisateurs";
  String _selectedPriority = "Normale";
  DateTime _selectedDate = DateTime.now();

  final List<String> _audiences = ["Tous les utilisateurs", "Étudiants uniquement", "Professeurs uniquement", "Administration"];
  final List<String> _priorities = ["Normale", "Urgente", "Information", "Événement"];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Sélecteur de date simple
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: pinkHeader),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
        title: const Text("Nouvelle Annonce", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Ciblage et Priorité"),
              const SizedBox(height: 15),

              // Ligne Cible et Priorité
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown("Cible", _selectedAudience, _audiences, (val) => setState(() => _selectedAudience = val!)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown("Type / Priorité", _selectedPriority, _priorities, (val) => setState(() => _selectedPriority = val!)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}", style: const TextStyle(fontSize: 14)),
                            const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              _sectionTitle("Contenu de l'annonce"),
              const SizedBox(height: 15),

              _buildTextField("Titre de l'annonce", "Ex: Fermeture exceptionnelle", _titleController, Icons.title, maxLines: 1),
              const SizedBox(height: 15),
              _buildTextField("Message détaillé", "Écrivez votre message ici...", _contentController, Icons.article, maxLines: 8),

              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (v) {}, activeColor: pinkHeader),
                  const Text("Envoyer une notification push", style: TextStyle(fontSize: 13)),
                ],
              ),

              const SizedBox(height: 30),

              // BOUTON PUBLIER
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Annonce publiée avec succès !"), backgroundColor: Colors.green)
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text("PUBLIER L'ANNONCE", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeBtn,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
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
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) => value == null || value.isEmpty ? "Ce champ est requis" : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: true,
        prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.grey) : Padding(padding: const EdgeInsets.only(bottom: 120), child: Icon(icon, color: Colors.grey)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}