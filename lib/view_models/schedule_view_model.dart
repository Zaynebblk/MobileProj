import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class ScheduleViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<ScheduleClass> classes = [];
  List<ProfessorAvailability> professors = [];

  bool get isLoading => _isLoading;

  // Stats simulées
  int get classesCount => 4;
  int get publishedCount => 3;
  int get professorCount => 3;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    // Données basées sur ton image
    classes = [
      ScheduleClass(id: "1", title: "1ère année", subtitle: "4 groupes", status: "publié"),
      ScheduleClass(id: "2", title: "2A - Réseaux et Télécommunications", subtitle: "2 groupes", status: "publié"),
      ScheduleClass(id: "3", title: "2A - Systèmes Embarqués", subtitle: "2 groupes", status: "publié"),
      ScheduleClass(id: "4", title: "3A - Réseaux et Télécommunications", subtitle: "2 groupes", status: "brouillon"),
    ];

    professors = [
      ProfessorAvailability(name: "Dr. BENALI Ahmed", status: "complet", hoursPerWeek: 12, coursesCount: 3),
      // Tu peux en ajouter d'autres ici
    ];

    _isLoading = false;
    notifyListeners();
  }
}