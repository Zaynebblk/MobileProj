import 'package:flutter/material.dart';
import '../viewmodels/profile_viewmodel.dart'; // New Import

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Connect to the ViewModel
    final vm = ProfileViewModel().getProfile();

    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E63),
        title: const Text('Mon Profil', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopProfileCard(vm.fullName), // Using Model Data

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  _buildStatCard(vm.gpa, "Moyenne", Colors.blue),
                  _buildStatCard(vm.credits, "Crédits", Colors.green),
                  _buildStatCard(vm.yearLevel, "Année", Colors.purple),
                ],
              ),
            ),

            _buildInfoSection(
              title: "Informations personnelles",
              items: [
                _buildInfoTile(Icons.person_outline, "Nom complet", vm.fullName),
                _buildInfoTile(Icons.email_outlined, "Email", vm.email),
                _buildInfoTile(Icons.phone_outlined, "Téléphone", vm.phone),
                _buildInfoTile(Icons.location_on_outlined, "Adresse", vm.address),
                _buildInfoTile(Icons.calendar_today_outlined, "Date de naissance", vm.birthDate),
              ],
            ),

            _buildInfoSection(
              title: "Informations académiques",
              items: [
                _buildInfoTile(Icons.badge_outlined, "Numéro d'étudiant", vm.studentId),
                _buildInfoTile(Icons.school_outlined, "Filière", vm.major),
                _buildInfoTile(Icons.event_available_outlined, "Année d'inscription", vm.academicYear),
                _buildInfoTile(Icons.groups_outlined, "Groupe", vm.group),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets (Same as before but using parameters)
  Widget _buildTopProfileCard(String name) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, backgroundColor: Colors.purple, child: Text("AA", style: TextStyle(color: Colors.white, fontSize: 30))),
          const SizedBox(height: 15),
          Text(name.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("Étudiant en Télécommunications", style: TextStyle(color: Colors.grey)),
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
      child: Column(children: [...items]),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey, size: 20),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
