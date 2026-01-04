class Note {
  final String id;
  final String title;
  final String type;
  final String teacher;
  final String date;
  final String students;
  final NoteStatus status;

  Note({
    required this.id,
    required this.title,
    required this.type,
    required this.teacher,
    required this.date,
    required this.students,
    required this.status,
  });
}

enum NoteStatus { pending, published }
