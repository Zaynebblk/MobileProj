import 'package:flutter/material.dart';
import '../models/rattrapage_model.dart'; // Assure-toi que le chemin est bon

class EditRattrapageView extends StatefulWidget {
  final RattrapageSession session;

  const EditRattrapageView({super.key, required this.session});

  @override
  State<EditRattrapageView> createState() => _EditRattrapageViewState();
}

class _EditRattrapageViewState extends State<EditRattrapageView> {
  // Contrôleurs
  late TextEditingController _subjectController;
  late TextEditingController _profController;
  late TextEditingController _roomController;
  late TextEditingController _capacityController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  // Liste fictive d'étudiants pour l'exemple admin
  final List<String> _registeredStudents = [
    "Amine Ben Ali",
    "Sarah Tounsi",
    "Mohamed Kallel",
    "Yasmine Dridi",
    "Khaled Ouerghi"
  ];

  @override
  void initState() {
    super.initState();
    // Pré-remplissage des données existantes
    _subjectController = TextEditingController(text: widget.session.subject);
    _profController = TextEditingController(text: widget.session.professor);
    _roomController = TextEditingController(text: widget.session.room);
    _capacityController = TextEditingController(text: widget.session.capacity.toString());
    _dateController = TextEditingController(text: widget.session.date);
    _timeController = TextEditingController(text: widget.session.time);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _profController.dispose();
    _roomController.dispose();
    _capacityController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinkHeader = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkHeader,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Gestion Session", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () => _confirmDelete(context),
            tooltip: "Supprimer la session",
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Déco
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: pinkHeader,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // --- SECTION 1 : FORMULAIRE DE MODIFICATION ---
                  const Text("Modifier les informations", style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
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
                        Row(
                          children: [
                            Expanded(child: _buildTextField("Date", Icons.calendar_month, _dateController)), // Pourrait être un DatePicker
                            const SizedBox(width: 10),
                            Expanded(child: _buildTextField("Heure", Icons.access_time, _timeController)),
                          ],
                        ),
                        const SizedBox(height: 15),
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

                  // --- SECTION 2 : GESTION DES INSCRITS (Puisque bouton supprimé) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Étudiants Inscrits", style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("${_registeredStudents.length}/${widget.session.capacity}", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _registeredStudents.length,
                      separatorBuilder: (ctx, i) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange[100],
                            child: Text(_registeredStudents[index][0], style: const TextStyle(color: Colors.deepOrange)),
                          ),
                          title: Text(_registeredStudents[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text("Inscrit le 05 Janv à 10:00"),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _registeredStudents.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Étudiant désinscrit.")));
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- BOUTON SAUVEGARDER ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Logique de sauvegarde ici
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Modifications enregistrées !"), backgroundColor: Colors.green)
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeBtn,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      icon: const Icon(Icons.save),
                      label: const Text("ENREGISTRER LES MODIFICATIONS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.orange)),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Supprimer la session ?"),
        content: const Text("Cette action est irréversible. Tous les étudiants seront notifiés."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annuler")),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              Navigator.pop(context); // Close page
            },
            child: const Text("SUPPRIMER", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}