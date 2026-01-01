import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Pour kIsWeb
import 'demandedoc.dart'; // Assurez-vous que ce fichier existe

// --- MODÈLE ---
class SchoolDocument {
  final String id;
  final String title;
  final String category;
  final String fileType;
  final String fileSize;
  final String date;

  SchoolDocument({
    required this.id,
    required this.title,
    required this.category,
    required this.fileType,
    required this.fileSize,
    required this.date,
  });

  factory SchoolDocument.fromJson(Map<String, dynamic> json) {
    return SchoolDocument(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      fileType: json['fileType'] ?? '',
      fileSize: json['fileSize'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

// --- ÉCRAN STATEFUL ---
class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  List<SchoolDocument> allDocuments = []; // Liste complète
  List<SchoolDocument> filteredDocuments = []; // Liste affichée
  bool isLoading = true;
  
  // Catégorie sélectionnée par défaut ("Tout" = pas de filtre)
  String selectedCategory = "Tout"; 
  
  // Liste des filtres disponibles
  final List<String> categories = ["Tout", "Attestations", "Notes", "Stages", "Divers"];

  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:5000';
    return 'http://10.0.2.2:5000';
  }

  Future<void> fetchDocuments() async {
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/documents'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          allDocuments = data.map((json) => SchoolDocument.fromJson(json)).toList();
          filteredDocuments = allDocuments; // Au début, on affiche tout
          isLoading = false;
        });
      } else {
        throw Exception('Erreur serveur');
      }
    } catch (e) {
      print("Erreur : $e");
      setState(() => isLoading = false);
    }
  }

  // Fonction de filtrage
  void _filterDocs(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "Tout") {
        filteredDocuments = allDocuments;
      } else {
        filteredDocuments = allDocuments
            .where((doc) => doc.category == category)
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        elevation: 0,
        title: const Text(
          "Documents",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Onglets (Filtres) ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Colors.grey[100], // Fond pour séparer visuellement
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((cat) {
                  return _buildPillTab(
                    cat, 
                    const Color.fromARGB(255, 198, 17, 4), // Couleur active (rouge de votre code)
                    selectedCategory == cat
                  );
                }).toList(),
              ),
            ),
          ),

          // --- Liste des Documents ---
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredDocuments.isEmpty
                    ? const Center(child: Text("Aucun document trouvé."))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredDocuments.length,
                        itemBuilder: (context, index) {
                          return _buildDocumentCard(filteredDocuments[index]);
                        },
                      ),
          ),
        ],
      ),

      // --- Bouton "Demander un document" ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => const DemanderDocumentScreen()),
             );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 183, 27, 13),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Demander un document",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget Onglet ---
  Widget _buildPillTab(String text, Color activeColor, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => _filterDocs(text),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? activeColor : Colors.grey.shade300,
            ),
            boxShadow: isSelected ? [
               BoxShadow(color: activeColor.withOpacity(0.3), blurRadius: 4, offset: Offset(0,2))
            ] : [],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget Carte Document ---
  Widget _buildDocumentCard(SchoolDocument doc) {
    // Détermination de l'icône selon la catégorie
    IconData icon;
    switch (doc.category) {
      case "Attestations": icon = Icons.description; break;
      case "Notes": icon = Icons.assignment_turned_in; break;
      case "Stages": icon = Icons.work; break;
      case "Divers": icon = Icons.credit_card; break;
      default: icon = Icons.insert_drive_file;
    }

    const Color categoryColor = Color.fromARGB(255, 41, 166, 249); // Bleu uniforme

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: categoryColor, size: 28),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${doc.fileType} | ${doc.fileSize} | ${doc.date}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          doc.category,
                          style: const TextStyle(
                            fontSize: 10,
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
            const SizedBox(width: 10),
            const Icon(
              Icons.download_for_offline,
              color: categoryColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}