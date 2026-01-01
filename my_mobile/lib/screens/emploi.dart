import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Pour kIsWeb

// --- MODÈLE ---
class Course {
  final String id;
  final String day;
  final String time;
  final String subject;
  final String type;
  final String professor;
  final String room;

  Course({
    required this.id,
    required this.day,
    required this.time,
    required this.subject,
    required this.type,
    required this.professor,
    required this.room,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'] ?? '',
      day: json['day'] ?? '',
      time: json['time'] ?? '',
      subject: json['subject'] ?? '',
      type: json['type'] ?? '',
      professor: json['professor'] ?? '',
      room: json['room'] ?? '',
    );
  }
}

// --- ÉCRAN STATEFUL ---
class EmploiScreen extends StatefulWidget {
  const EmploiScreen({super.key});

  @override
  State<EmploiScreen> createState() => _EmploiScreenState();
}

class _EmploiScreenState extends State<EmploiScreen> {
  List<Course> coursesList = [];
  bool isLoading = true;

  // Liste pour définir l'ordre d'affichage des jours
  final List<String> weekDays = [
    "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"
  ];

  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:5000';
    return 'http://10.0.2.2:5000';
  }

  Future<void> fetchCourses() async {
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/courses'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          coursesList = data.map((json) => Course.fromJson(json)).toList();
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

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2FF),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        elevation: 0,
        title: const Text(
          "Emploi du temps",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (coursesList.isEmpty)
                      const Center(child: Text("Aucun cours disponible.")),

                    // On boucle sur chaque jour de la semaine
                    ...weekDays.map((dayName) {
                      // On filtre les cours pour ce jour précis
                      List<Course> dailyCourses = coursesList
                          .where((c) => c.day.toLowerCase() == dayName.toLowerCase())
                          .toList();

                      // Si pas de cours ce jour-là, on n'affiche rien (SizedBox vide)
                      if (dailyCourses.isEmpty) return const SizedBox.shrink();

                      return Column(
                        children: [
                          _buildDay(dayName, dailyCourses),
                          const SizedBox(height: 20),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget jour (Reçoit une liste de Course dynamique)
  Widget _buildDay(String day, List<Course> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // On génère les cartes de cours
        ...courses.map((course) => _courseCard(course)),
      ],
    );
  }

  // Widget cours (Style identique à votre code)
  Widget _courseCard(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.time, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Expanded ajouté pour éviter l'overflow si le titre est long
                child: Text(
                  course.subject,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  course.type,
                  style: TextStyle(color: Colors.blue[800]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "${course.professor} • ${course.room}",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}