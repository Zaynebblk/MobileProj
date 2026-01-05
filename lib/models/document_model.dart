class DocumentModel {
  final String id;
  final String title;       // ex: Convention de Stage
  final String studentName; // ex: Mohamed Ali
  final String type;        // ex: Stage, Scolarité
  final String date;        // Date de la demande
  final String status;      // En attente, Signé, Rejeté

  DocumentModel({
    required this.id,
    required this.title,
    required this.studentName,
    required this.type,
    required this.date,
    required this.status,
  });
}