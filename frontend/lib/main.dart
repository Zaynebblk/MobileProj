import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/ticket.dart';
import 'views/auth/login.dart';

class TicketProvider extends ChangeNotifier {
  final List<Ticket> _tickets = [
    Ticket(
      id: "#2024-156",
      titre: "Problème de connexion WiFi",
      auteur: "MADDAHI Manel",
      service: "Technique",
      date: "16 Nov 2025",
      priorite: "haute",
    ),
    Ticket(
      id: "#2024-155",
      titre: "Demande de relevé de notes",
      auteur: "BEN SALEM Youssef",
      service: "Administratif",
      date: "15 Nov 2025",
      priorite: "moyenne",
      statut: "en cours",
    ),
    Ticket(
      id: "#2024-154",
      titre: "Modification emploi du temps",
      auteur: "Dr. BENALI",
      service: "Scolarité",
      date: "15 Nov 2025",
      priorite: "haute",
    ),
    Ticket(
      id: "#2024-153",
      titre: "Accès bibliothèque",
      auteur: "AHMED Fatma",
      service: "Services",
      date: "14 Nov 2025",
      priorite: "basse",
      statut: "resolu",
    ),
  ];

  List<Ticket> get tickets => _tickets;

  void updateStatus(String id, String newStatus) {
    final ticket = _tickets.firstWhere((t) => t.id == id);
    ticket.statut = newStatus;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TicketProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
