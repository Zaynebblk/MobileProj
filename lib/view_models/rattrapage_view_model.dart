import 'package:flutter/material.dart';
import '../models/rattrapage_model.dart';

class RattrapageViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<RattrapageSession> _sessions = [];

  bool get isLoading => _isLoading;
  List<RattrapageSession> get sessions => _sessions;

  // Stats simulées comme sur l'image
  int get sessionsCount => 3;
  int get inscritsCount => 20;
  int get enAttenteCount => 2;

  Future<void> loadSessions() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(milliseconds: 500)); // Simulation chargement

    // Données basées sur ton image "Rattrapages"
    _sessions = [
      RattrapageSession(
        id: "1",
        subject: "Systèmes d'exploitation",
        professor: "Dr. GHARBI",
        date: "25 Nov 2025",
        time: "14:00-16:00",
        room: "Salle A103",
        registered: 12,
        capacity: 30,
      ),
      RattrapageSession(
        id: "2",
        subject: "Mathématiques",
        professor: "Dr. TRABELSI",
        date: "27 Nov 2025",
        time: "08:00-10:00",
        room: "Salle A101",
        registered: 8,
        capacity: 30,
      ),
      RattrapageSession(
        id: "3",
        subject: "Base de données",
        professor: "Dr. SAIDI",
        date: "30 Nov 2025",
        time: "10:00-12:00",
        room: "Salle B201",
        registered: 0,
        capacity: 30,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}