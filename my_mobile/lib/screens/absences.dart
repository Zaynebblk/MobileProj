import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Pour kIsWeb

// --- MODÈLE ---
class Absence {
  final String id;
  final String subject;
  final String type;
  final String time;
  final String date;
  final bool isJustified;

  Absence({
    required this.id,
    required this.subject,
    required this.type,
    required this.time,
    required this.date,
    required this.isJustified,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      id: json['_id'] ?? '',
      subject: json['subject'] ?? '',
      type: json['type'] ?? '',
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      isJustified: json['isJustified'] ?? false,
    );
  }

  // Petit helper pour formater "TD - 09h00 | Date" comme sur votre maquette
  String get formattedDetails => "$type - $time | $date";
}

// --- ÉCRAN (STATEFUL) ---
class AbsencesScreen extends StatefulWidget {
  const AbsencesScreen({super.key});

  @override
  State<AbsencesScreen> createState() => _AbsencesScreenState();
}

class _AbsencesScreenState extends State<AbsencesScreen> {
  List<Absence> absencesList = [];
  bool isLoading = true;

  // URL API
  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:5000';
    return 'http://10.0.2.2:5000';
  }

  // Récupération des données
  Future<void> fetchAbsences() async {
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/absences'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          absencesList = data.map((json) => Absence.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erreur de chargement');
      }
    } catch (e) {
      print("Erreur: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAbsences();
  }

  @override
  Widget build(BuildContext context) {
    // Calculs dynamiques
    int totalAbsences = absencesList.length;
    int unjustifiedCount = absencesList.where((a) => !a.isJustified).length;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Absences",
          style: TextStyle(
            color: Color.fromARGB(255, 251, 249, 249),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        elevation: 1,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 246, 245, 245)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Récapitulative des Absences
                  Container(
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
                        const Text(
                          "Absences",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(197, 183, 4, 4),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSummaryCard(
                              'Total absences',
                              totalAbsences.toString(), // Donnée dynamique
                              Colors.blue,
                            ),
                            _buildSummaryCard(
                              'Non justifiées',
                              unjustifiedCount.toString(), // Donnée dynamique
                              const Color.fromARGB(194, 230, 20, 5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Message d'Alerte (S'affiche seulement si on a des absences non justifiées)
                  if (unjustifiedCount > 0)
                    _buildWarningAlert(
                      "Attention!",
                      "Vous avez $unjustifiedCount absence(s) non justifiée(s). Veuillez les justifier au plus vite.",
                    ),

                  const SizedBox(height: 20),

                  // Liste des Modules (Générée depuis la base de données)
                  if (absencesList.isEmpty)
                     const Center(child: Text("Aucune absence enregistrée. Bravo !")),
                     
                  ...absencesList.map((absence) => _buildModuleCard(
                        title: absence.subject,
                        details: absence.formattedDetails, // utilise le getter créé en haut
                        absenceType: absence.isJustified ? "Justifiée" : "Non Justifiée",
                        color: absence.isJustified ? Colors.green.shade100 : Colors.red.shade100,
                        justified: absence.isJustified,
                      )),
                ],
              ),
            ),
    );
  }

  // --- WIDGETS UI (INCHANGÉS) ---

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          count,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildModuleCard({
    required String title,
    required String details,
    required String absenceType,
    required Color color,
    required bool justified,
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              details,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  absenceType,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: justified
                        ? const Color.fromARGB(255, 15, 100, 219)
                        : Colors.red.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningAlert(String title, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 20), // Marge en bas ajoutée
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 231, 47, 6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning, color: const Color.fromARGB(255, 204, 38, 4), size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 188, 46, 6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}