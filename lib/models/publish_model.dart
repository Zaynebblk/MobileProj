class ExamSession {
  final String subject;
  final String type; // Ex: "Examen final"
  final String group; // Ex: "2A - RT"
  final String professor;
  final String date;
  final int studentCount;
  final bool isReady; // Pour le badge "Prêt"

  ExamSession({
    required this.subject,
    required this.type,
    required this.group,
    required this.professor,
    required this.date,
    required this.studentCount,
    this.isReady = true,
  });
}