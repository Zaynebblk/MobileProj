class Announcement {
  final String id;
  final String title;
  final String date;
  final String audience; // "Tous", "Étudiants", "Profs"
  final String status;   // "Publié", "Brouillon", "Programmé"
  final int views;       // Nombre de vues

  Announcement({
    required this.id,
    required this.title,
    required this.date,
    required this.audience,
    required this.status,
    required this.views,
  });
}