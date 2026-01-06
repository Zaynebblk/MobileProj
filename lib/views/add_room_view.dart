import 'package:flutter/material.dart';

class AddRoomView extends StatefulWidget {
  const AddRoomView({super.key});

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> {
  final _formKey = GlobalKey<FormState>();

  // Couleurs du thème
  final pinkHeader = const Color(0xFFE91E63);
  final orangeBtn = const Color(0xFFE65100);
  final creamBg = const Color(0xFFFFF8E1);

  // Contrôleurs
  final _nameController = TextEditingController();
  final _capacityController = TextEditingController();
  final _locationController = TextEditingController();

  // Valeurs par défaut
  String _selectedType = "Salle de Cours (TD)";
  final List<String> _roomTypes = ["Salle de Cours (TD)", "Amphithéâtre", "Laboratoire Informatique", "Salle de Réunion", "Atelier"];

  // Équipements (Checkboxes)
  bool _hasProjector = false;
  bool _hasAC = false;
  bool _hasComputer = false;

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    _locationController.dispose();
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
        title: const Text("Nouvelle Salle", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Identification"),
              const SizedBox(height: 15),
              
              _buildTextField("Nom de la salle", "Ex: Salle A101", _nameController, Icons.meeting_room),
              const SizedBox(height: 15),
              _buildDropdown("Type de local", _selectedType, _roomTypes, (val) => setState(() => _selectedType = val!)),
              
              const SizedBox(height: 25),
              _sectionTitle("Capacité & Localisation"),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField("Capacité (Places)", "Ex: 40", _capacityController, Icons.groups, isNumber: true),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildTextField("Étage / Bloc", "Ex: Bloc B - 1er", _locationController, Icons.map),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              _sectionTitle("Équipements disponibles"),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  children: [
                    _buildSwitch("Vidéo Projecteur / DataShow", _hasProjector, (v) => setState(() => _hasProjector = v)),
                    const Divider(height: 1),
                    _buildSwitch("Climatisation", _hasAC, (v) => setState(() => _hasAC = v)),
                    const Divider(height: 1),
                    _buildSwitch("Poste Ordinateur Prof", _hasComputer, (v) => setState(() => _hasComputer = v)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // BOUTON ENREGISTRER
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulation de l'ajout
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Salle ajoutée avec succès !"), backgroundColor: Colors.green)
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text("ENREGISTRER LA SALLE", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown)
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, IconData icon, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) => value == null || value.isEmpty ? "Champ requis" : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(fontSize: 14)),
      value: value, 
      onChanged: onChanged,
      activeColor: const Color(0xFFE65100),
      dense: true,
    );
  }
}