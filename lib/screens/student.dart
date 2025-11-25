import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --------------------------
      //  TOP APPBAR (Avatar + Name + Time)
      // --------------------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/user.jpg'), // change later
            ),
            SizedBox(width: 10),
            Text(
              "blabla",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),

            Icon(Icons.logout, size: 18),
          ],
        ),
      ),

      // --------------------------
      // MAIN BODY SCROLL
      // --------------------------
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner image
            Container(
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/supcom.jpeg"), // change later
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 15),
            Text(
              "MENU PRINCIPAL",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),

            // GRID MENU
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  buildMenu("Note d’info", Icons.description),
                  buildMenu("Message", Icons.message),

                  buildMenu("Absences", Icons.event_busy),
                  buildMenu("Résultats", Icons.school),
                  buildMenu("Emploi", Icons.calendar_today),
                  buildMenu("Mon Groupe", Icons.group),

                  buildMenu("Documents", Icons.folder),
                  buildMenu("Partage", Icons.share),
                  buildMenu("Site Web", Icons.public),
                ],
              ),
            ),
          ],
        ),
      ),

      // --------------------------
      // BOTTOM NAVIGATION BAR
      // --------------------------
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Icons.home, true),
            navItem(Icons.calendar_today, false),
            navItem(Icons.settings, false),
            navItem(Icons.person, false),
          ],
        ),
      ),
    );
  }

  // --------------------------
  // MENU ITEM WIDGET
  // --------------------------
  Widget buildMenu(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // --------------------------
  // BOTTOM NAV ITEM
  // --------------------------
  Widget navItem(IconData icon, bool active) {
    return Icon(icon, size: 30, color: active ? Colors.white : Colors.white70);
  }
}
