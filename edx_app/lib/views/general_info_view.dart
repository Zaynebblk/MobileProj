import 'package:flutter/material.dart';
import '../viewmodels/info_viewmodel.dart';

class GeneralInfoView extends StatelessWidget {
  const GeneralInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = InfoViewModel().getInfoData();

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
            _buildAnnouncement(vm.announcement),
            const SizedBox(height: 16),
            _buildCardSection(
              title: "Questions fréquentes",
              icon: Icons.help_outline,
              items: vm.faqs.map((faq) => _buildExpansionTile(faq['q']!, faq['a']!)).toList(),
            ),
            const SizedBox(height: 16),
            _buildCardSection(
              title: "Calendrier académique 2024-2025",
              icon: Icons.calendar_today,
              items: vm.events.map((e) => _buildCalendarRow(e.title, e.date, e.status, e.statusColor)).toList(),
            ),
            const SizedBox(height: 16),
            _buildCardSection(
              title: "Services étudiants",
              icon: Icons.people_outline,
              items: vm.services.map((s) => _buildServiceTile(s['name']!, s['bureau']!, s['email']!)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildAnnouncement(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFFFF9C4), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orangeAccent)),
      child: Row(children: [const Icon(Icons.error_outline, color: Colors.orange), const SizedBox(width: 12), Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.brown)))]),
    );
  }

  Widget _buildCardSection({required String title, required IconData icon, required List<Widget> items}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [ListTile(leading: Icon(icon, color: Colors.blueGrey), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))), const Divider(height: 1), ...items]),
    );
  }

  Widget _buildExpansionTile(String q, String a) => ExpansionTile(title: Text(q, style: const TextStyle(fontSize: 14)), children: [Padding(padding: const EdgeInsets.all(12), child: Text(a, style: const TextStyle(color: Colors.grey)))]);

  Widget _buildCalendarRow(String title, String date, String status, Color statusColor) => ListTile(
    title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    subtitle: Text(date, style: const TextStyle(fontSize: 12)),
    trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold))),
  );

  Widget _buildServiceTile(String name, String bureau, String email) => ListTile(title: Text(name), subtitle: Text("$bureau\n$email", style: const TextStyle(fontSize: 12)), isThreeLine: true);
}