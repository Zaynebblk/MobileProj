import 'package:flutter/material.dart';
import '../models/admin_model.dart';

class AdminViewModel extends ChangeNotifier {
  bool _isLoading = false;
  AdminDashboardStats? _stats;
  List<AdminMenuItem> _menuItems = [];

  // Getters
  bool get isLoading => _isLoading;
  AdminDashboardStats? get stats => _stats;
  List<AdminMenuItem> get menuItems => _menuItems;

  // Simulate fetching data from an API
  Future<void> fetchAdminData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Fake network delay

    // 1. Load the Stats (Top Card)
    _stats = AdminDashboardStats(
      ticketsCount: 15,
      usersCount: 342,
      rattrapagesCount: 8,
    );

    // 2. Load the 9 Menu Items (The Grid)
    _menuItems = [
      AdminMenuItem(title: "Publier Notes", icon: Icons.assignment_turned_in, color: const Color(0xFFFFE0B2)), // Orange pastel
      AdminMenuItem(title: "Tickets", icon: Icons.confirmation_number, color: const Color(0xFFFFCDD2)), // Pink pastel
      AdminMenuItem(title: "Rattrapages", icon: Icons.schedule, color: const Color(0xFFFFCCBC)), // Deep Orange pastel
      
      AdminMenuItem(title: "Utilisateurs", icon: Icons.people, color: const Color(0xFFBBDEFB)), // Blue pastel
      AdminMenuItem(title: "Emplois", icon: Icons.calendar_today, color: const Color(0xFFE1BEE7)), // Purple pastel
      AdminMenuItem(title: "Matières", icon: Icons.menu_book, color: const Color(0xFFC8E6C9)), // Green pastel
      
      AdminMenuItem(title: "Annonces", icon: Icons.campaign, color: const Color(0xFFFFCDD2)), // Red pastel
      AdminMenuItem(title: "Documents", icon: Icons.folder, color: const Color(0xFFFFF9C4)), // Yellow pastel
      AdminMenuItem(title: "Salles", icon: Icons.meeting_room, color: const Color(0xFFD1C4E9)), // Deep Purple pastel
    ];

    _isLoading = false;
    notifyListeners();
  }
}