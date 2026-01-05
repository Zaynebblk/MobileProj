class AppUser {
  final String id;
  final String name;
  final String email;
  final String role;    // Étudiant, Professeur, Administrateur
  final String details; // Ex: "2A - RT" ou "Réseaux"
  final String status;  // actif, inactif

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.details,
    required this.status,
  });
}