import 'package:flutter/material.dart';
import '../models/subject_model.dart';

class SubjectViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Subject> subjects = [];
  
  bool get isLoading => _isLoading;

  // Stats
  int get totalSubjects => subjects.length;
  double get totalCoeff => subjects.fold(0, (sum, item) => sum + item.coeff);
  int get semester1Count => subjects.where((s) => s.semester == 1).length;

  Future<void> loadSubjects() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600)); // Simule le chargement

    // Données fictives
    subjects = [
      Subject(id: "1", name: "Traitement du Signal", code: "TS-201", professor: "Dr. Gharbi", coeff: 3.0, semester: 1, type: "Cours + TD"),
      Subject(id: "2", name: "Réseaux IP Avancés", code: "RES-304", professor: "Dr. Benali", coeff: 4.0, semester: 1, type: "Cours + TP"),
      Subject(id: "3", name: "Développement Mobile", code: "DEV-102", professor: "Mme. Salhi", coeff: 2.5, semester: 1, type: "TP"),
      Subject(id: "4", name: "Systèmes Embarqués", code: "SYS-401", professor: "Dr. Foulen", coeff: 3.5, semester: 2, type: "Cours + TP"),
      Subject(id: "5", name: "Anglais Technique", code: "LANG-101", professor: "Mme. Smith", coeff: 1.5, semester: 2, type: "TD"),
    ];

    _isLoading = false;
    notifyListeners();
  }
}