import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Light purple background
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63), // Pink header
        title: const Text('Mon Profil', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Top Card: Name & Avatar
            _buildTopProfileCard(),

            // 2. Stats Row: Moyenne, Crédits, Année
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  _buildStatCard("13.00", "Moyenne", Colors.blue), // Your specific moyenne
                  _buildStatCard("156", "Crédits", Colors.green),
                  _buildStatCard("2ème", "Année", Colors.purple),
                ],
              ),
            ),

            // 3. Section: Informations personnelles
            _buildInfoSection(
              title: "Informations personnelles",
              items: [
                _buildInfoTile(Icons.person_outline, "Nom complet", "Ahmed Ben Ameur"),
                _buildInfoTile(Icons.email_outlined, "Email", "ahmed.benameur@supcom.tn"),
                _buildInfoTile(Icons.phone_outlined, "Téléphone", "+216 55 181 294"),
                _buildInfoTile(Icons.location_on_outlined, "Adresse", "Cité El Ghazala, Ariana 2083"),
                _buildInfoTile(Icons.calendar_today_outlined, "Date de naissance", "15 Mars 2003"),
              ],
            ),

            // 4. Section: Informations académiques
            _buildInfoSection(
              title: "Informations académiques",
              items: [
                _buildInfoTile(Icons.badge_outlined, "Numéro d'étudiant", "2023-012345"),
                _buildInfoTile(Icons.school_outlined, "Filière", "Ingénieur en Télécommunications"),
                _buildInfoTile(Icons.event_available_outlined, "Année d'inscription", "2023-2024"),
                _buildInfoTile(Icons.groups_outlined, "Groupe", "2A-G2"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Text("Statut", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(width: 20),
                      _buildStatusTag("Régulier", Colors.green),
                      const SizedBox(width: 10),
                      _buildStatusTag("Boursier", Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildTopProfileCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Color(0xFF7B1FA2), Color(0xFF8C9EFF)]),
                ),
                child: const Center(child: Text("AA", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))),
              ),
              const CircleAvatar(radius: 15, backgroundColor: Colors.blue, child: Icon(Icons.camera_alt, color: Colors.white, size: 15)),
            ],
          ),
          const SizedBox(height: 15),
          const Text("AHMED BEN AMEUR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("Étudiant en Télécommunications", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          _buildStatusTag("Inscrit", Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatCard(String val, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Text(val, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({required String title, required List<Widget> items}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), trailing: const Icon(Icons.edit, size: 18)),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey, size: 20),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildStatusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
