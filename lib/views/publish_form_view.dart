import 'package:flutter/material.dart';

class PublishFormView extends StatefulWidget {
  const PublishFormView({super.key});

  @override
  State<PublishFormView> createState() => _PublishFormViewState();
}

class _PublishFormViewState extends State<PublishFormView> {
  // Valeurs sélectionnées
  String? selectedLevel;
  String? selectedClass;
  String? selectedSubject;
  String? selectedType;
  
  // Contrôleurs
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  // Gestion de l'affichage (Mode individuel ou classe entière)
  bool isIndividualMode = false;

  @override
  Widget build(BuildContext context) {
    final pinkColor = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Nouvelle Publication", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER DECORATIF ---
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: pinkColor,
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
                  
                  // --- SECTION 1: CIBLAGE ---
                  const Text("1. Ciblage", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
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
                        _buildDropdown("Niveau", ["INDP1", "INDP2", "INDP3"], selectedLevel, (val) => setState(() => selectedLevel = val)),
                        const SizedBox(height: 15),
                        _buildDropdown("Classe / Groupe", ["Groupe A", "Groupe B", "Groupe C", "Tout la promo"], selectedClass, (val) => setState(() => selectedClass = val)),
                        const SizedBox(height: 15),
                        _buildDropdown("Matière", ["Réseaux Mobiles", "Développement Mobile", "Sécurité", "Mathématiques"], selectedSubject, (val) => setState(() => selectedSubject = val)),
                        const SizedBox(height: 15),
                         _buildDropdown("Type d'évaluation", ["DS", "Examen", "TP", "Projet"], selectedType, (val) => setState(() => selectedType = val)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- SECTION 2: MODE DE SAISIE ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("2. Saisie des notes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
                      Switch(
                        activeColor: pinkColor,
                        value: isIndividualMode, 
                        onChanged: (val) => setState(() => isIndividualMode = val)
                      ),
                    ],
                  ),
                  Text(
                    isIndividualMode ? "Mode : Étudiant unique" : "Mode : Import Fichier (Classe)",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: isIndividualMode 
                      ? _buildIndividualForm() // Formulaire simple
                      : _buildFileUploadUI(),  // Zone d'upload
                  ),

                  const SizedBox(height: 30),

                  // --- BOUTON VALIDER ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Simulation de validation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: const Text("Publication effectuée avec succès !"),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          )
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeBtn,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("PUBLIER LES NOTES", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  // --- WIDGETS INTERNES ---

  Widget _buildDropdown(String label, List<String> items, String? currentValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              hint: Text("Choisir $label", style: const TextStyle(color: Colors.grey, fontSize: 14)),
              isExpanded: true,
              items: items.map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndividualForm() {
    return Column(
      children: [
        TextField(
          controller: _studentNameController,
          decoration: InputDecoration(
            labelText: "Nom de l'étudiant",
            prefixIcon: const Icon(Icons.person_outline, color: Colors.orange),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _noteController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Note / 20",
            prefixIcon: const Icon(Icons.grade_outlined, color: Colors.orange),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadUI() {
    return GestureDetector(
      onTap: () {
        // Action d'upload fictive
      },
      child: DottedBorderContainer(
        child: Column(
          children: [
            const Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.orange),
            const SizedBox(height: 10),
            const Text("Appuyez pour importer un fichier", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Formats: CSV, PDF, Excel", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// Widget utilitaire pour l'effet de bordure en pointillés (Upload)
class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange, width: 1, style: BorderStyle.solid), // Simplifié car border pointillé natif complexe sans package
      ),
      child: child,
    );
  }
}