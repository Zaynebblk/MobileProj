import 'package:flutter/material.dart';
import '../models/announcement_model.dart';

class AnnouncementViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Announcement> announcements = [];

  bool get isLoading => _isLoading;

  // Stats simulées
  int get totalAnnouncements => announcements.length;
  int get activeCount => announcements.where((a) => a.status == "Publié").length;
  int get viewsCount => announcements.fold(0, (sum, item) => sum + item.views);

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    // Données fictives
    announcements = [
      Announcement(id: "1", title: "Début des inscriptions 2024", date: "05 Jan 2024", audience: "Tous", status: "Publié", views: 1250),
      Announcement(id: "2", title: "Maintenance serveur ce soir", date: "08 Jan 2024", audience: "Étudiants", status: "Publié", views: 430),
      Announcement(id: "3", title: "Réunion pédagogique", date: "12 Jan 2024", audience: "Profs", status: "Programmé", views: 0),
      Announcement(id: "4", title: "Hackathon SupCom - Infos", date: "15 Jan 2024", audience: "Étudiants", status: "Brouillon", views: 0),
    ];

    _isLoading = false;
    notifyListeners();
  }
}