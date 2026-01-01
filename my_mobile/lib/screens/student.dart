import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pour la connexion
import 'dart:convert'; // Pour lire les données

// Tes imports de pages
import 'emploi.dart';
import 'group.dart';
import 'messages.dart';
import 'partage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'absences.dart';
import 'info.dart';
import 'resultats.dart';
import 'Documents.dart';

// On passe en StatefulWidget pour gérer le chargement des données
class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  // ---------------------------------------------------------
  // 🔧 CONFIGURATION DE LA CONNEXION
  // ---------------------------------------------------------
  
  // 1. L'ID de Salma que tu m'as donné
  final String studentId = "69568094a80bc4f943d55964"; 

  // 2. L'adresse du serveur (10.0.2.2 pour l'émulateur Android)
  final String serverUrl = "http://localhost:5000/api/students";

  // Variables pour stocker les infos
  Map<String, dynamic>? studentData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudent(); // On lance la récupération dès le démarrage
  }

  // Fonction pour récupérer les données depuis Node.js/MongoDB
  Future<void> fetchStudent() async {
    try {
      final response = await http.get(Uri.parse('$serverUrl/$studentId'));

      if (response.statusCode == 200) {
        setState(() {
          studentData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Erreur serveur : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur de connexion : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // --- PHOTO DE PROFIL DYNAMIQUE ---
            CircleAvatar(
              radius: 20,
              // Si on a chargé les données et qu'il y a une URL, on l'affiche.
              // Sinon, on affiche l'image par défaut assets/user.jpg
              backgroundImage: (studentData != null && studentData!['photoUrl'] != null)
                  ? NetworkImage(studentData!['photoUrl'])
                  : const AssetImage('assets/user.jpg') as ImageProvider,
            ),
            const SizedBox(width: 10),
            
            // --- NOM ET PRÉNOM DYNAMIQUES ---
            isLoading
                ? const Text("Chargement...", style: TextStyle(color: Colors.black, fontSize: 12))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${studentData!['firstName']} ${studentData!['lastName']}", // Nom Prénom
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      // J'ajoute la classe en petit en dessous si tu veux
                      if (studentData!['studentClass'] != null)
                        Text(
                          studentData!['studentClass'],
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                    ],
                  ),
            
            const Spacer(),
            const Icon(Icons.logout, size: 18, color: Colors.black),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Supcom
            Container(
              height: 160,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/supcom.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 15),
            const Text(
              "MENU PRINCIPAL",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // GRID MENU (Ton code de navigation conservé)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  buildMenu(context, "Note d’info", Icons.description, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NoteInfoScreen()));
                  }),
                  buildMenu(context, "Messages", Icons.message, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen()));
                  }),
                  buildMenu(context, "Absences", Icons.event_busy, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AbsencesScreen()));
                  }),
                  buildMenu(context, "Résultats", Icons.school, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultatsScreen()));
                  }),
                  buildMenu(context, "Emploi", Icons.calendar_today, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EmploiScreen()));
                  }),
                  buildMenu(context, "Mon Groupe", Icons.group, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupScreen()));
                  }),
                  buildMenu(context, "Documents", Icons.folder, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentsScreen()));
                  }),
                  buildMenu(context, "Partage", Icons.share, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PartageDocumentsPage()));
                  }),
                  buildMenu(context, "Site Web", Icons.public, onTap: () async {
                    final Uri url = Uri.parse("https://supcom.tn/");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      print("Impossible d’ouvrir le site");
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
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

  // --- WIDGETS D'AIDE (HELPERS) ---
  
  Widget buildMenu(BuildContext context, String title, IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool active) {
    return Icon(icon, size: 30, color: active ? Colors.white : Colors.white70);
  }
}