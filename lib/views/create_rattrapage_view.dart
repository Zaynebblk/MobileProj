import 'package:flutter/material.dart';

class CreateRattrapageView extends StatefulWidget {
  const CreateRattrapageView({super.key});

  @override
  State<CreateRattrapageView> createState() => _CreateRattrapageViewState();
}

class _CreateRattrapageViewState extends State<CreateRattrapageView> {
  // Contrôleurs pour les champs
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _profController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  
  // Variables pour Date et Heure
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    // --- PALETTE DE COULEURS ---
    final pinkHeader = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: creamBg,
      // --- HEADER ---
      appBar: AppBar(
        backgroundColor: pinkHeader,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Nouvelle Session", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Décoration Header (Arrondi du bas)
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: pinkHeader,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Détails du Rattrapage", 
                    style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 20),

                  // --- FORMULAIRE ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: Column(
                      children: [
                        _buildTextField("Matière", Icons.book, _subjectController),
                        const SizedBox(height: 15),
                        _buildTextField("Professeur", Icons.person, _profController),
                        const SizedBox(height: 15),
                        
                        // Ligne Date et Heure
                        Row(
                          children: [
                            Expanded(child: _buildDatePicker(context)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildTimePicker(context)),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Ligne Salle et Capacité
                        Row(
                          children: [
                            Expanded(child: _buildTextField("Salle", Icons.meeting_room, _roomController)),
                            const SizedBox(width: 10),
                            Expanded(child: _buildTextField("Capacité", Icons.groups, _capacityController, isNumber: true)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- BOUTON D'ACTION ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Appel au ViewModel pour sauvegarder
                        Navigator.pop(context); // Retour après création
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Session planifiée avec succès !"), backgroundColor: Colors.green)
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeBtn,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text("CONFIRMER LA PLANIFICATION", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Champ Texte Standard
  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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

  // Widget Sélecteur de Date
  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Color(0xFFE91E63)), // Rose Calendar
              ),
              child: child!,
            );
          },
        );
        if (picked != null) setState(() => _selectedDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: Colors.orange, size: 20),
            const SizedBox(width: 8),
            Text(
              _selectedDate == null 
                  ? "Date" 
                  : "${_selectedDate!.day}/${_selectedDate!.month}",
              style: TextStyle(color: _selectedDate == null ? Colors.grey[600] : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Sélecteur d'Heure
  Widget _buildTimePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
             return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Color(0xFFE91E63)),
              ),
              child: child!,
            );
          }
        );
        if (picked != null) setState(() => _selectedTime = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Colors.orange, size: 20),
            const SizedBox(width: 8),
            Text(
              _selectedTime == null 
                  ? "Heure" 
                  : _selectedTime!.format(context),
              style: TextStyle(color: _selectedTime == null ? Colors.grey[600] : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}