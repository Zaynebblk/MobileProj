import 'package:flutter/material.dart';
import '../../widgets/admin/adminheader.dart';
import '../../widgets/admin/admin_stats_card.dart';
import '../../widgets/admin/admin_bottom_nav.dart';
import '../tickets/tickets.dart';
import '../notes/notes.dart';
import '../../widgets/admin/admin_grid_item.dart';


class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F8F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: const AdminBottomNav(
    currentIndex: 0,
  ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AdminHeader(),
            const SizedBox(height: 15),
            const AdminStatsCard(),
            const SizedBox(height: 20),
            _sectionTitle("ESPACE ADMINISTRATEUR"),
            _buildGridMenu(context),
            const SizedBox(height: 20),
            _sectionTitle("Actions prioritaires"),
            _buildQuickAction(),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black87),
      ),
    );
  }

  Widget _buildGridMenu(BuildContext context) {
     final items = [
    {"icon": Icons.upload, "label": "Publier Notes", "color": Colors.orange},
    {"icon": Icons.confirmation_number, "label": "Tickets", "color": Colors.red},
    {"icon": Icons.school, "label": "Rattrapages", "color": Colors.deepOrange},
    {"icon": Icons.group, "label": "Utilisateurs", "color": Colors.blue},
    {"icon": Icons.calendar_month, "label": "Emplois", "color": Colors.indigo},
    {"icon": Icons.menu_book, "label": "Matières", "color": Colors.green},
    {"icon": Icons.campaign, "label": "Annonces", "color": Colors.pink},
    {"icon": Icons.description, "label": "Rapports", "color": Colors.teal},
    {"icon": Icons.folder, "label": "Documents", "color": Colors.amber},
    {"icon": Icons.meeting_room, "label": "Salles", "color": Colors.blueGrey},
    {"icon": Icons.bar_chart, "label": "Statistiques", "color": Colors.lightBlue},
    {"icon": Icons.settings, "label": "Système", "color": Colors.deepPurple},
  ];

     return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 120,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
        itemBuilder: (context, index) {
          return AdminGridItemCustom(
            icon: items[index]["icon"] as IconData,
            label: items[index]["label"] as String,
            color: items[index]["color"] as Color,
            onTap: () {
              switch (items[index]["label"]) {
                case "Publier Notes":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PublierNotesPage()),
                  );
                  break;
                case "Tickets":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TicketsPage()),
                  );
                  break;
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildQuickAction() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.pending_actions,
              color: Colors.red, size: 26),
        ),
        const SizedBox(width: 15),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Traiter les tickets",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("15 tickets en attente",
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "15",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        )
      ],
    ),
  );
}
}