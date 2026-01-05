import 'package:flutter/material.dart';

// Represents one of the 9 buttons in the grid
class AdminMenuItem {
  final String title;
  final IconData icon;
  final Color color; // The color of the icon circle

  AdminMenuItem({
    required this.title,
    required this.icon,
    required this.color,
  });
}

// Represents the data for the top stats card (Tickets, Users, etc.)
class AdminDashboardStats {
  final int ticketsCount;
  final int usersCount;
  final int rattrapagesCount;

  AdminDashboardStats({
    required this.ticketsCount,
    required this.usersCount,
    required this.rattrapagesCount,
  });
}