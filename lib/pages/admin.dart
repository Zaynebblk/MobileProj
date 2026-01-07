import 'package:flutter/material.dart';

 import 'notes.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F8F7),
      bottomNavigationBar: buildBottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            _buildStatsCard(),
            const SizedBox(height: 20),
            _buildSectionTitle("ESPACE ADMINISTRATEUR"),
            _buildGridMenu(context),
            const SizedBox(height: 20),
            _buildSectionTitle("Actions prioritaires"),
            _buildQuickAction(),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // HEADER
  // -------------------------------
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
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
            child: Image(
              image: AssetImage("assets/imgs/supcom.jpg"),
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
            children: [
              Row(
                children: [
                  const Icon(Icons.admin_panel_settings,
                      color: Colors.white, size: 30),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Admin SUPCOM",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text("Administrateur",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const Text("20:49",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        )
      ],
    );
  }

  // -------------------------------
  // STATS CARD
  // -------------------------------
  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _singleStat("15", "Tickets"),
          _singleStat("342", "Utilisateurs"),
          _singleStat("8", "Rattrapages"),
        ],
      ),
    );
  }

  Widget _singleStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  // -------------------------------
  // SECTION TITLE
  // -------------------------------
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 17,
            color: Colors.black87,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  // -------------------------------
  // GRID MENU (MODIFIÉ)
  // -------------------------------
  Widget _buildGridMenu(BuildContext context) {
    final items = [
      {"icon": Icons.upload, "label": "Publier Notes"},
      {"icon": Icons.confirmation_number, "label": "Tickets"},
      {"icon": Icons.watch_later, "label": "Rattrapages"},

      {"icon": Icons.group, "label": "Utilisateurs"},
      {"icon": Icons.calendar_today, "label": "Emplois"},
      {"icon": Icons.book_online, "label": "Matières"},

      {"icon": Icons.campaign, "label": "Annonces"},
      {"icon": Icons.assignment, "label": "Rapports"},
      {"icon": Icons.folder_copy, "label": "Documents"},

      {"icon": Icons.meeting_room, "label": "Salles"},
      {"icon": Icons.bar_chart, "label": "Statistiques"},
      {"icon": Icons.settings, "label": "Système"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 115,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemBuilder: (context, index) {
          return _gridItem(
            items[index]["icon"] as IconData,
            items[index]["label"] as String,
            () {
              // -------------------------
              // NAVIGATION ICI
              // -------------------------
              switch (items[index]["label"]) {
                case "Publier Notes":
                  Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => PublierNotesPage()),
                   );
                  

                case "Tickets":
                  break;

                case "Utilisateurs":
                  break;

                // ajoute les autres si tu veux

                default:
                  break;
              }
            },
          );
        },
      ),
    );
  }

  // GRID ITEM (MODIFIÉ AVEC onTap)
  Widget _gridItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green, size: 35),
            const SizedBox(height: 10),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87))
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // QUICK ACTION
  // -------------------------------
  Widget _buildQuickAction() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      child: Row(
        children: [
          const Icon(Icons.pending_actions,
              color: Colors.red, size: 30),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Traiter les tickets",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Text("15 tickets en attente",
                  style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  // -------------------------------
  // BOTTOM NAVIGATION BAR
  // -------------------------------
  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
