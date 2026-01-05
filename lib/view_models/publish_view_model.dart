import 'package:flutter/material.dart';
import '../models/publish_model.dart';

class PublishViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<ExamSession> _pendingExams = []; // Notes prêtes à publier
  List<ExamSession> _publishedExams = []; // Récemment publiées

  bool get isLoading => _isLoading;
  List<ExamSession> get pendingExams => _pendingExams;
  List<ExamSession> get publishedExams => _publishedExams;

  // Statistiques pour les cartes du haut
  int get pendingCount => _pendingExams.length;
  int get publishedCount => _publishedExams.length;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800)); // Simulation API

    // Données basées sur ton image
    _pendingExams = [
      ExamSession(
        subject: "Réseaux informatiques",
        type: "Examen final",
        group: "2A - RT",
        professor: "Dr. BENALI Ahmed",
        date: "15 Nov 2025",
        studentCount: 45,
      ),
      ExamSession(
        subject: "Mathématiques",
        type: "Contrôle continu",
        group: "2A - RT",
        professor: "Dr. TRABELSI",
        date: "14 Nov 2025",
        studentCount: 45,
      ),
      ExamSession(
        subject: "Programmation C++",
        type: "TP",
        group: "2A - RT",
        professor: "Dr. HAMDI",
        date: "13 Nov 2025",
        studentCount: 42,
      ),
    ];

    _publishedExams = [
      ExamSession(
        subject: "Base de données",
        type: "Examen",
        group: "2A - RT",
        professor: "Mme. KAABACHI",
        date: "10 Nov 2025",
        studentCount: 45,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}