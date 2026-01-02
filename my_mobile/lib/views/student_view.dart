import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Import du ViewModel
import '../viewmodels/student_viewmodel.dart';

// Tes imports de navigation (Assure-toi que les chemins sont corrects)
import 'emploi_view.dart';
import 'group_view.dart';
import 'messages_view.dart';
import 'partage_view.dart';
import 'absences_view.dart';
import 'info_view.dart';
import 'resultats_view.dart';
import 'documents_view.dart'; 

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    super.initState();
    // On lance la récupération des données via le ViewModel dès le démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentViewModel>().fetchStudent();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Écoute les changements du ViewModel (Data Binding)
    final viewModel = context.watch<StudentViewModel>();
    final student = viewModel.student;

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
              backgroundImage: (student?.photoUrl != null)
                  ? NetworkImage(student!.photoUrl!)
                  : const AssetImage('assets/user.jpg') as ImageProvider,
            ),
            const SizedBox(width: 10),
            
            // --- NOM ET PRÉNOM DYNAMIQUES ---
            viewModel.isLoading
                ? const Text("Chargement...", style: TextStyle(color: Colors.black, fontSize: 12))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${student?.firstName ?? ''} ${student?.lastName ?? ''}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      if (student?.studentClass != null)
                        Text(
                          student!.studentClass!,
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

            // GRID MENU
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