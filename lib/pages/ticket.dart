class Ticket {
  final String id;
  final String titre;
  final String auteur;
  final String service;
  final String date;
  final String priorite;
  String statut;

  Ticket({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.service,
    required this.date,
    required this.priorite,
    this.statut = "nouveau",
  });
}
