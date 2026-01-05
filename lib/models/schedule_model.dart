class ScheduleClass {
  final String id;
  final String title;
  final String subtitle; // ex: "4 groupes"
  final String status;   // "publié", "brouillon"

  ScheduleClass({required this.id, required this.title, required this.subtitle, required this.status});
}

class ProfessorAvailability {
  final String name;
  final String status;   // "complet", "disponible"
  final int hoursPerWeek;
  final int coursesCount;

  ProfessorAvailability({required this.name, required this.status, required this.hoursPerWeek, required this.coursesCount});
}