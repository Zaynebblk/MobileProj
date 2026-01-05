class RattrapageSession {
  final String id;
  final String subject;    // Ex: Systèmes d'exploitation
  final String professor;  // Ex: Dr. GHARBI
  final String date;       // Ex: 25 Nov 2025
  final String time;       // Ex: 14:00-16:00
  final String room;       // Ex: Salle A103
  final int registered;    // Ex: 12
  final int capacity;      // Ex: 30

  RattrapageSession({
    required this.id,
    required this.subject,
    required this.professor,
    required this.date,
    required this.time,
    required this.room,
    required this.registered,
    required this.capacity,
  });

  // Pour calculer le pourcentage de remplissage (0.0 à 1.0)
  double get progress => capacity == 0 ? 0 : registered / capacity;
}