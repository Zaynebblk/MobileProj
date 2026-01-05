import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class TicketViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Ticket> _tickets = [];

  bool get isLoading => _isLoading;
  List<Ticket> get tickets => _tickets;

  // Calcul dynamique des statistiques pour les cartes du haut
  int get countNouveaux => _tickets.where((t) => t.status == "nouveau").length;
  int get countEnCours => _tickets.where((t) => t.status == "en cours").length;
  int get countResolus => _tickets.where((t) => t.status == "resolu").length;

  Future<void> loadTickets() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600)); // Simulation API

    // Données basées exactement sur ton image
    _tickets = [
      Ticket(
        id: "#2024-156",
        title: "Problème de connexion WiFi",
        userName: "MADDAHI Manel",
        category: "Technique",
        date: "16 Nov 2025",
        priority: "haute",
        status: "nouveau",
      ),
      Ticket(
        id: "#2024-155",
        title: "Demande de relevé de notes",
        userName: "BEN SALEM Youssef",
        category: "Administratif",
        date: "15 Nov 2025",
        priority: "moyenne",
        status: "en cours",
      ),
      Ticket(
        id: "#2024-154",
        title: "Modification emploi du temps",
        userName: "Dr. BENALI",
        category: "Scolarité",
        date: "15 Nov 2025",
        priority: "haute",
        status: "nouveau",
      ),
      Ticket(
        id: "#2024-153",
        title: "Accès bibliothèque",
        userName: "AHMED Fatma",
        category: "Services",
        date: "14 Nov 2025",
        priority: "basse",
        status: "resolu",
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}