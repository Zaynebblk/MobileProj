import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        title: const Text('À propos de SUP\'COM', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ADDED THIS SECTION FOR YOUR IMAGE ---
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/supcom.jpg', // Ensure this matches your pubspec.yaml exactly
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          Text("Image non trouvée", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 1. Intro Section
            const Text(
              "Présentation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
            ),
            const SizedBox(height: 8),
            const Text(
              "L'École Supérieure des Communications de Tunis est la grande école d'ingénieurs des télécommunications en Tunisie.",
              style: TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // 2. Statistics Grid (En chiffres)
            const Text(
              "En chiffres",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
              children: [
                _buildStatCard("1200+", "Étudiants", Icons.school, Colors.blue),
                _buildStatCard("90+", "Enseignants", Icons.person, Colors.orange),
                _buildStatCard("30+", "Partenaires", Icons.handshake, Colors.green),
                _buildStatCard("15", "Laboratoires", Icons.science, Colors.purple),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Departments List
            _buildSectionCard(
              title: "Nos Départements",
              icon: Icons.account_tree_outlined,
              items: [
                _buildSimpleTile("Réseaux et Services"),
                _buildSimpleTile("Systèmes de Communications"),
                _buildSimpleTile("Technologies du Numérique"),
                _buildSimpleTile("Langues et Management"),
              ],
            ),
            const SizedBox(height: 20),

            // 4. Contact & Location
            _buildSectionCard(
              title: "Coordonnées",
              icon: Icons.location_on_outlined,
              items: [
                _buildContactTile(Icons.map, "Cité Technologique des Communications, Raoued"),
                _buildContactTile(Icons.phone, "+216 70 011 000"),
                _buildContactTile(Icons.web, "www.supcom.tn"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // UI Helpers (Remaining the same)
  Widget _buildStatCard(String val, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required List<Widget> items}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: const Color(0xFFE91E63)),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSimpleTile(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
    );
  }

  Widget _buildContactTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, size: 18, color: Colors.blueGrey),
      title: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}