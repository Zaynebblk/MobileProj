import 'package:flutter/material.dart';
import '../viewmodels/about_viewmodel.dart'; // Import the logic

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the data from the ViewModel
    final vm = AboutViewModel().getAboutData();

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
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/supcom.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildImageError(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Présentation", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(vm.presentation, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
            const SizedBox(height: 20),
            const Text("En chiffres", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
              children: [
                _buildStatCard(vm.studentsCount, "Étudiants", Icons.school, Colors.blue),
                _buildStatCard(vm.teachersCount, "Enseignants", Icons.person, Colors.orange),
                _buildStatCard(vm.partnersCount, "Partenaires", Icons.handshake, Colors.green),
                _buildStatCard(vm.labsCount, "Laboratoires", Icons.science, Colors.purple),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: "Nos Départements",
              icon: Icons.account_tree_outlined,
              items: vm.departments.map((dept) => _buildSimpleTile(dept)).toList(),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: "Coordonnées",
              icon: Icons.location_on_outlined,
              items: [
                _buildContactTile(Icons.map, vm.address),
                _buildContactTile(Icons.phone, vm.phone),
                _buildContactTile(Icons.web, vm.website),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildImageError() {
    return Container(
      height: 200, width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
      child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
      child: Column(children: [
        ListTile(leading: Icon(icon, color: const Color(0xFFE91E63)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
        const Divider(height: 1),
        ...items,
      ]),
    );
  }

  Widget _buildSimpleTile(String title) => ListTile(title: Text(title, style: const TextStyle(fontSize: 14)), trailing: const Icon(Icons.check_circle_outline, color: Colors.green, size: 18));
  Widget _buildContactTile(IconData icon, String text) => ListTile(leading: Icon(icon, size: 18, color: Colors.blueGrey), title: Text(text, style: const TextStyle(fontSize: 13)));
}