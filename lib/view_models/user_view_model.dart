import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<AppUser> _allUsers = [];
  List<AppUser> _filteredUsers = [];
  String _selectedFilter = "Tous"; // Filtre actuel

  bool get isLoading => _isLoading;
  List<AppUser> get users => _filteredUsers;
  String get selectedFilter => _selectedFilter;

  // Stats
  int get totalCount => _allUsers.length;
  int get studentCount => _allUsers.where((u) => u.role == "Étudiant").length;
  int get profCount => _allUsers.where((u) => u.role == "Professeur").length;
  int get adminCount => _allUsers.where((u) => u.role == "Administrateur").length;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(milliseconds: 500)); 

    // Données basées sur l'image fournie
    _allUsers = [
      AppUser(id: "1", name: "MADDAHI Manel", email: "manel.maddahi@supcom.tn", role: "Étudiant", details: "2A - RT", status: "actif"),
      AppUser(id: "2", name: "BEN SALEM Youssef", email: "youssef.bensalem@supcom.tn", role: "Étudiant", details: "2A - RT", status: "actif"),
      AppUser(id: "3", name: "Dr. BENALI Ahmed", email: "ahmed.benali@supcom.tn", role: "Professeur", details: "Réseaux", status: "actif"),
      AppUser(id: "4", name: "Dr. GHARBI", email: "gharbi@supcom.tn", role: "Professeur", details: "Systèmes", status: "actif"),
      AppUser(id: "5", name: "Admin Système", email: "admin@supcom.tn", role: "Administrateur", details: "DSI", status: "actif"),
    ];

    _applyFilter();
    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_selectedFilter == "Tous") {
      _filteredUsers = List.from(_allUsers);
    } else {
      _filteredUsers = _allUsers.where((u) => u.role == _selectedFilter).toList();
    }
  }
}