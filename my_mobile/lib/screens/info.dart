import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pour faire les requêtes API
import 'dart:convert'; // Pour décoder le JSON
import 'package:flutter/foundation.dart'; // Pour savoir si on est sur le Web (kIsWeb)

// 1. LE MODÈLE DE DONNÉES
// Sert à transformer le JSON reçu de MongoDB en objet Dart utilisable
class InfoNote {
  final String id;
  final String title;
  final String description;
  final String date;
  final String category;

  InfoNote({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  factory InfoNote.fromJson(Map<String, dynamic> json) {
    return InfoNote(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      category: json['category'] ?? 'Général',
    );
  }
}

// 2. L'ÉCRAN PRINCIPAL (Devenu StatefulWidget)
class NoteInfoScreen extends StatefulWidget {
  const NoteInfoScreen({super.key});

  @override
  State<NoteInfoScreen> createState() => _NoteInfoScreenState();
}

class _NoteInfoScreenState extends State<NoteInfoScreen> {
  // Liste qui va contenir les notes reçues du serveur
  List<InfoNote> notes = [];
  // Variable pour savoir si ça charge encore
  bool isLoading = true;

  // Fonction pour avoir la bonne URL selon l'appareil
  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:5000'; // Pour Chrome
    } else {
      return 'http://10.0.2.2:5000'; // Pour Émulateur Android
    }
  }

  // Fonction pour récupérer les données depuis le Backend
  Future<void> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/info-notes'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          // On transforme la liste JSON en liste d'objets InfoNote
          notes = data.map((json) => InfoNote.fromJson(json)).toList();
          isLoading = false; // Le chargement est fini
        });
      } else {
        throw Exception('Erreur serveur');
      }
    } catch (e) {
      print("Erreur : $e");
      setState(() => isLoading = false);
    }
  }

  // Au démarrage de l'écran, on lance la récupération des données
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  // Logique pour choisir l'icône selon la catégorie du JSON
  IconData _getIconForCategory(String category) {
    switch (category) {
      case "Emploi du temps": return Icons.schedule;
      case "Vie associative": return Icons.group_add;
      case "Examen": return Icons.assignment;
      case "Général": return Icons.people;
      default: return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        elevation: 0,
        title: const Text(
          "Note d'info",
          style: TextStyle(
            color: Color.fromARGB(255, 240, 239, 239),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 251, 250, 250)),
      ),
      // Si ça charge, on affiche un rond qui tourne, sinon on affiche la liste
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informations importantes",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Si la liste est vide
                  if (notes.isEmpty)
                    const Center(child: Text("Aucune information disponible.")),

                  // Ici, on génère une carte pour chaque note trouvée dans la liste 'notes'
                  ...notes.map((note) => _buildInfoCard(
                        icon: _getIconForCategory(note.category),
                        title: note.title,
                        description: note.description,
                        date: note.date,
                        category: note.category,
                        categoryColor: Colors.blue,
                      )),
                ],
              ),
            ),
    );
  }

  // VOTRE WIDGET DE CARTE (INCHANGÉ, juste réutilisé)
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required String date,
    required String category,
    required Color categoryColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color.fromARGB(255, 205, 24, 15), size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 11,
                      color: categoryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}