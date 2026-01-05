class Room {
  final String id;
  final String name;      // ex: A-101
  final String type;      // ex: Amphi, TD, Labo
  final int capacity;     // ex: 30 places
  final String status;    // Libre, Occupée, Maintenance
  final bool hasProjector; // Équipement

  Room({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.status,
    required this.hasProjector,
  });
}