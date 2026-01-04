import 'package:flutter/material.dart';
import '../../widgets/prof/prof_bottom_navbar.dart';
import '../../widgets/prof/prof_grid_item.dart';

class ProfHomePage extends StatefulWidget {
  const ProfHomePage({super.key});

  @override
  State<ProfHomePage> createState() => _ProfHomePageState();
}

class _ProfHomePageState extends State<ProfHomePage> {
  int currentIndex = 0;

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

      bottomNavigationBar: ProfBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            _buildStatsCard(),
            const SizedBox(height: 20),
            _buildSectionTitle("ESPACE PROFESSEUR"),
            _buildGridMenu(),
            const SizedBox(height: 15),
            _buildSectionTitle("Actions rapides"),
            _buildQuickAction(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xfff23859), Color(0xfffb729e)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.15,
            child: Image.asset(
              "assets/imgs/supcom.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.school, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. BENALI Ahmed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Professeur",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Text("20:49",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }

  // ================= STATS =================
  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _StatItem(value: "8", label: "Cours"),
          _StatItem(value: "156", label: "Étudiants"),
          _StatItem(value: "12", label: "Examens"),
        ],
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ================= GRID MENU =================
  Widget _buildGridMenu() {
    final items = [
    {"icon": Icons.book, "label": "Mes Cours", "color": Colors.green},
    {"icon": Icons.group, "label": "Étudiants", "color": Colors.teal},
    {"icon": Icons.checklist, "label": "Notes", "color": Colors.indigo},

    {"icon": Icons.event_busy, "label": "Absences", "color": Colors.red},
    {"icon": Icons.calendar_month, "label": "Emploi", "color": Colors.blue},
    {"icon": Icons.folder, "label": "Documents", "color": Colors.amber},

    {"icon": Icons.message, "label": "Messages", "color": Colors.cyan},
    {"icon": Icons.assignment, "label": "Examens", "color": Colors.orange},
    {"icon": Icons.campaign, "label": "Annonces", "color": Colors.pink},

    {"icon": Icons.bar_chart, "label": "Statistiques", "color": Colors.lightBlue},
    {"icon": Icons.event, "label": "Calendrier", "color": Colors.deepPurple},
    {"icon": Icons.folder_open, "label": "Ressources", "color": Colors.lime},
  ];

    return Container(
    color: const Color(0xffE9FBF2), // fond vert clair comme l’image
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
      itemBuilder: (_, index) {
        return ProfGridItem(
          icon: items[index]["icon"] as IconData,
          label: items[index]["label"] as String,
          color: items[index]["color"] as Color,
        );
      },
    ),
  );
}

  // ================= QUICK ACTION =================
  Widget _buildQuickAction() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.edit_calendar, color: Colors.red, size: 30),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Marquer les absences",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Cours du jour", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= SMALL WIDGETS =================

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}


