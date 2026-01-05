class Ticket {
  final String id;        // Ex: #2024-156
  final String title;     // Ex: Problème de connexion WiFi
  final String userName;  // Ex: MADDAHI Manel
  final String category;  // Ex: Technique, Scolarité
  final String date;      // Ex: 16 Nov 2025
  final String priority;  // "haute", "moyenne", "basse"
  final String status;    // "nouveau", "en cours", "resolu"

  Ticket({
    required this.id,
    required this.title,
    required this.userName,
    required this.category,
    required this.date,
    required this.priority,
    required this.status,
  });
}