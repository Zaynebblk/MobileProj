import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Pour kIsWeb

// --- MODÈLE DE DONNÉES ---
class Result {
  final String id;
  final String moduleName;
  final double cc;
  final double exam;
  final int credits;

  Result({
    required this.id,
    required this.moduleName,
    required this.cc,
    required this.exam,
    required this.credits,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['_id'] ?? '',
      moduleName: json['moduleName'] ?? '',
      // On force la conversion en double même si c'est un int dans le JSON
      cc: (json['cc'] ?? 0).toDouble(),
      exam: (json['exam'] ?? 0).toDouble(),
      credits: json['credits'] ?? 1,
    );
  }

  // Calcul de la moyenne du module (40% CC, 60% Examen)
  double get average => (cc * 0.4) + (exam * 0.6);

  // Statut
  bool get isValidated => average >= 10.0;
}

// --- ÉCRAN STATEFUL ---
class ResultatsScreen extends StatefulWidget {
  const ResultatsScreen({super.key});

  @override
  State<ResultatsScreen> createState() => _ResultatsScreenState();
}

class _ResultatsScreenState extends State<ResultatsScreen> {
  List<Result> resultsList = [];
  bool isLoading = true;
  double generalAverage = 0.0; // Pour stocker la moyenne générale calculée

  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:5000';
    return 'http://10.0.2.2:5000';
  }

  Future<void> fetchResults() async {
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/results'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        setState(() {
          resultsList = data.map((json) => Result.fromJson(json)).toList();
          _calculateGeneralAverage(); // On lance le calcul global
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

  // Fonction pour calculer la moyenne générale du semestre
  void _calculateGeneralAverage() {
    if (resultsList.isEmpty) {
      generalAverage = 0.0;
      return;
    }

    double totalPoints = 0;
    int totalCredits = 0;

    for (var result in resultsList) {
      totalPoints += result.average * result.credits;
      totalCredits += result.credits;
    }

    if (totalCredits > 0) {
      generalAverage = totalPoints / totalCredits;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResults();
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
          "Résultats",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Carte de la Moyenne Générale (Dynamique) ---
                  _buildGeneralAverageCard(
                    average: generalAverage.toStringAsFixed(2), // 2 chiffres après la virgule
                    semester: "Semestre 1 - 2024/2025",
                    color: primaryColor,
                  ),
                  const SizedBox(height: 20),

                  // --- Liste des Modules (Générée depuis la DB) ---
                  if (resultsList.isEmpty)
                    const Center(child: Text("Aucun résultat disponible.")),

                  ...resultsList.map((result) => _buildModuleResultCard(
                    title: result.moduleName,
                    cc: result.cc.toString(),
                    exam: result.exam.toString(),
                    moduleAverage: result.average.toStringAsFixed(1), // Calculé auto
                    credits: "${result.credits} crédits",
                    // Logique couleur et texte auto
                    status: result.isValidated ? "Validé" : "Rattrapage",
                    statusColor: result.isValidated ? Colors.green : Colors.red,
                  )),
                ],
              ),
            ),
    );
  }

  // --- Widget pour la Moyenne Générale ---
  Widget _buildGeneralAverageCard({
    required String average,
    required String semester,
    required Color color,
  }) {
    return Container(
      width: double.infinity, // Prend toute la largeur
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Moyenne générale",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            average,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            semester,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget pour une Carte de Module ---
  Widget _buildModuleResultCard({
    required String title,
    required String cc,
    required String exam,
    required String moduleAverage,
    required String credits,
    required String status,
    required Color statusColor,
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
            // Titre et Crédits sur la même ligne ou en dessous
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  credits,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            
            // Ligne des notes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMarkDetail("CC", cc, Colors.black87),
                _buildMarkDetail("Examen", exam, Colors.black87),
                _buildMarkDetail("Moyenne", moduleAverage, Colors.blue),
              ],
            ),
            
            const SizedBox(height: 15),
            
            // Badge de statut (Validé / Rattrapage)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget pour un Détail de Note ---
  Widget _buildMarkDetail(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}