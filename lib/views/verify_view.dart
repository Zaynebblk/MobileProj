import 'package:flutter/material.dart';
import '../models/publish_model.dart'; // Assure-toi que le chemin est bon pour ton modèle ExamSession

class VerifyView extends StatelessWidget {
  final ExamSession exam;

  const VerifyView({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final pinkColor = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);
    final greenColor = const Color(0xFF4CAF50);
    final redColor = const Color(0xFFE53935);

    // Données simulées pour la prévisualisation (à remplacer par ton ViewModel plus tard)
    final List<Map<String, dynamic>> mockStudents = [
      {'name': 'Ben Ali Ahmed', 'id': 'IND-2024-01', 'note': 14.5},
      {'name': 'Trabelsi Sarah', 'id': 'IND-2024-02', 'note': 17.0},
      {'name': 'Jaziri Mohamed', 'id': 'IND-2024-03', 'note': 08.25}, // Note faible
      {'name': 'Gharbi Yasmine', 'id': 'IND-2024-04', 'note': 12.0},
      {'name': 'Masmoudi Omar', 'id': 'IND-2024-05', 'note': 19.5},
      {'name': 'Kefi Linda', 'id': 'IND-2024-06', 'note': 09.75},
    ];

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkColor,
        title: const Text("Vérification Notes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Colors.white),
            onPressed: () {
               // Action pour télécharger le PDF original
            },
            tooltip: "Voir le PV original",
          )
        ],
      ),
      body: Column(
        children: [
          // --- 1. RÉSUMÉ DE LA SESSION ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: pinkColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exam.subject, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text("${exam.type} • ${exam.group}", style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                      child: Text("${exam.studentCount} copies", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                // Stats rapides
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildHeaderStat("13.45", "Moyenne", Icons.analytics),
                    _buildHeaderStat("85%", "Réussite", Icons.pie_chart),
                    _buildHeaderStat("19.5", "Max Note", Icons.emoji_events),
                  ],
                ),
              ],
            ),
          ),

          // --- 2. LISTE DES ÉTUDIANTS (PREVIEW) ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Aperçu des notes saisies", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                    ),
                    child: Column(
                      children: mockStudents.map((student) {
                        bool isValid = student['note'] >= 10;
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isValid ? greenColor.withOpacity(0.1) : redColor.withOpacity(0.1),
                                child: Text(
                                  student['name'][0], 
                                  style: TextStyle(color: isValid ? greenColor : redColor, fontWeight: FontWeight.bold)
                                ),
                              ),
                              title: Text(student['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("ID: ${student['id']}"),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isValid ? greenColor.withOpacity(0.1) : redColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: isValid ? greenColor.withOpacity(0.3) : redColor.withOpacity(0.3)),
                                ),
                                child: Text(
                                  "${student['note']}/20",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isValid ? Colors.green[800] : Colors.red[800],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            if (student != mockStudents.last) // Séparateur sauf pour le dernier
                              const Divider(height: 1, indent: 70, endIndent: 20),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Avertissement
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.orange),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Vérifiez bien les notes extrêmes (0 ou 20) avant de valider la publication.",
                            style: TextStyle(color: Colors.brown, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 3. BARRE D'ACTION BAS ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Logique de signalement
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signalement envoyé à l'administration")));
                    },
                    icon: const Icon(Icons.report_problem_outlined, size: 18),
                    label: const Text("Signaler Erreur"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: redColor,
                      side: BorderSide(color: redColor),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Logique de validation
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Session validée avec succès"), backgroundColor: Colors.green));
                    },
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: const Text("Tout est Bon"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}