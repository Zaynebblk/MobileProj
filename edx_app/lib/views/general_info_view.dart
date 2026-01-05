import 'package:flutter/material.dart';

class GeneralInfoView extends StatelessWidget {
  const GeneralInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        title: const Text('Informations Générales', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. Yellow Announcement Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9C4), // Light yellow
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orangeAccent),
              ),
              child: const Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Annonce importante: Les inscriptions pour les examens de rattrapage sont ouvertes jusqu'au 20 novembre 2024.",
                      style: TextStyle(fontSize: 13, color: Colors.brown),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. FAQ Section (Questions fréquentes)
            _buildCardSection(
              title: "Questions fréquentes",
              icon: Icons.help_outline,
              items: [
                _buildExpansionTile("Comment consulter mes notes ?", "Via le portail étudiant section Résultats."),
                _buildExpansionTile("Comment justifier une absence ?", "Envoyez un justificatif à la scolarité sous 48h."),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Academic Calendar
            _buildCardSection(
              title: "Calendrier académique 2024-2025",
              icon: Icons.calendar_today,
              items: [
                _buildCalendarRow("Semestre 1", "16 sept 2024 - 15 jan 2025", "En cours", Colors.blue),
                _buildCalendarRow("Examens S1", "20 jan - 05 fév 2025", "À venir", Colors.grey),
                _buildCalendarRow("Vacances d'hiver", "06 fév - 16 fév 2025", "À venir", Colors.grey),
              ],
            ),
            const SizedBox(height: 16),

            // 4. Student Services
            _buildCardSection(
              title: "Services étudiants",
              icon: Icons.people_outline,
              items: [
                _buildServiceTile("Scolarité", "Bureau A.1.01", "scolarite@supcom.tn"),
                _buildServiceTile("Bibliothèque", "Bâtiment c", "biblio@supcom.tn"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets to make it look like your images ---

  Widget _buildCardSection({required String title, required IconData icon, required List<Widget> items}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.blueGrey),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String q, String a) {
    return ExpansionTile(title: Text(q, style: const TextStyle(fontSize: 14)), children: [
      Padding(padding: const EdgeInsets.all(12), child: Text(a, style: const TextStyle(color: Colors.grey)))
    ]);
  }

  Widget _buildCalendarRow(String title, String date, String status, Color statusColor) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(date, style: const TextStyle(fontSize: 12)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildServiceTile(String name, String bureau, String email) {
    return ListTile(
      title: Text(name),
      subtitle: Text("$bureau\n$email", style: const TextStyle(fontSize: 12)),
      isThreeLine: true,
    );
  }
}