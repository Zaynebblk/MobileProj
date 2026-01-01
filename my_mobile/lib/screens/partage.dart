import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Pour kIsWeb
import 'package:url_launcher/url_launcher.dart'; // Pour ouvrir les liens

import 'partager.dart'; // (Page d'upload - assure-toi que le nom du fichier est bon)
// Page de visualisation

// --- CONFIGURATION ---
const String serverIP = "192.168.100.17"; // ⚠️ METS TON ADRESSE IP ICI
const String port = "5000";

class PartageDocumentsPage extends StatefulWidget {
  const PartageDocumentsPage({super.key});

  @override
  State<PartageDocumentsPage> createState() => _PartageDocumentsPageState();
}

class _PartageDocumentsPageState extends State<PartageDocumentsPage> {
  // --- VARIABLES D'ÉTAT ---
  String selectedMatiere = "Toutes les matières";
  String selectedType = "Tous les types";

  List<dynamic> documents = []; // La liste vide qui va recevoir les données
  bool isLoading = true; // Pour afficher un rond de chargement au début

  @override
  void initState() {
    super.initState();
    fetchDocuments(); // On charge les données dès le démarrage
  }

  // --- LOGIQUE SERVEUR ---

  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:$port';
    return 'http://$serverIP:$port';
  }

  // Fonction pour récupérer la liste depuis le backend
  Future<void> fetchDocuments() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/shared-docs'));

      if (response.statusCode == 200) {
        setState(() {
          documents = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Erreur serveur: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Erreur connexion: $e");
      setState(() => isLoading = false);
    }
  }

  // Fonction pour ouvrir le PDF
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible d'ouvrir le fichier : $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        title: const Text("Partage Documents",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 244, 243, 243),
            )),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchDocuments, // Bouton pour rafraîchir manuellement
          )
        ],
      ),

      body: RefreshIndicator(
        onRefresh: fetchDocuments, // Permet de tirer vers le bas pour rafraîchir
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔍 Barre de recherche
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Rechercher un document…",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🎛️ Filtres
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDropdown(
                    value: selectedMatiere,
                    items: ["Toutes les matières", "Analyse", "Réseaux", "Programmation C", "Algorithmique"],
                    onChanged: (v) => setState(() => selectedMatiere = v!),
                  ),
                  const SizedBox(width: 12),
                  _buildDropdown(
                    value: selectedType,
                    items: ["Tous les types", "TD", "Examen", "Cours", "TP", "Rapport"],
                    onChanged: (v) => setState(() => selectedType = v!),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ➕ Bouton partager (MODIFIÉ POUR RAFRAÎCHISSEMENT AUTO)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // 1. On attend le retour de la page d'upload
                    // Assure-toi que UploadDocumentPage est bien importée
                    // (le fichier que je t'ai donné juste avant)
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UploadDocumentPage()),
                    );

                    // 2. Si on revient avec 'true', on recharge la liste
                    if (result == true) {
                      fetchDocuments();
                    }
                  },
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 8, 151, 234)),
                  label: const Text(
                    "Partager un document",
                    style: TextStyle(color: Color.fromARGB(255, 8, 151, 234)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 241, 241, 243),
                    minimumSize: const Size(200, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Affichage dynamique du nombre de docs
              Text(
                "${documents.length} document(s) trouvé(s)",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // 📄 Liste des documents (DYNAMIQUE)
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (documents.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Aucun document partagé pour le moment."),
                  ),
                )
              else
                // On boucle sur la liste récupérée du serveur
                ListView.builder(
                  shrinkWrap: true, // Important dans un SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    return _buildDocumentCard(
                      title: doc['title'] ?? "Sans titre",
                      teacher: doc['teacher'] ?? "Inconnu",
                      date: doc['date'] ?? "--/--/--",
                      tag: doc['tag'] ?? "Autre",
                      description: doc['description'] ?? "",
                      note: doc['note'] ?? "Nouveau",
                      views: doc['views'] ?? "0",
                      fileUrl: doc['fileUrl'], // On passe l'URL du fichier
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================
  // 🔻 Widget Dropdown
  // ===============================
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    // Sécurité au cas où la valeur sélectionnée n'est pas dans la liste
    String dropdownValue = items.contains(value) ? value : items[0];

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: onChanged,
          underline: Container(),
          isExpanded: true,
          isDense: true, // Pour éviter les débordements
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis))).toList(),
        ),
      ),
    );
  }

  // ===============================
  // 📄 Widget Document Card
  // ===============================
  Widget _buildDocumentCard({
    required String title,
    required String teacher,
    required String date,
    required String description,
    required String tag,
    required String note,
    required String views,
    String? fileUrl, // URL optionnelle
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔵 Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE4E1FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(tag, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),

          const SizedBox(height: 8),

          // 📘 Titre
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 4),
          Text(description),

          const SizedBox(height: 4),
          Text("$teacher • $date", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.remove_red_eye, size: 18),
                  Text(" $views"),
                  const SizedBox(width: 12),
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(" $note"),
                ],
              ),
              Row(
                children: [
                  // Bouton VOIR
                  TextButton(
                    onPressed: () {
                      if (fileUrl != null) {
                        _launchURL(fileUrl); // Ouvre le lien direct
                      } else {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lien non disponible")));
                      }
                    },
                    child: const Text("Voir"),
                  ),

                  // Bouton TÉLÉCHARGER
                  ElevatedButton(
                    onPressed: () {
                      if (fileUrl != null) {
                         _launchURL(fileUrl); // Ouvre aussi le lien (le navigateur proposera de télécharger)
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 191, 35, 35),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Télécharger",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}