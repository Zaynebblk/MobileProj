import 'package:flutter/material.dart';
import '../../models/note.dart';

class NotesViewModel extends ChangeNotifier {
  final List<Note> _pendingNotes = [
    Note(
      id: '1',
      title: "Réseaux informatiques",
      type: "Examen final - 2A - RT",
      teacher: "Dr. BENALI Ahmed",
      date: "15 Nov 2025",
      students: "45 étudiants",
      status: NoteStatus.pending,
    ),
    Note(
      id: '2',
      title: "Mathématiques",
      type: "Contrôle continu - 2A - RT",
      teacher: "Dr. TRABELSI",
      date: "14 Nov 2025",
      students: "45 étudiants",
      status: NoteStatus.pending,
    ),
    Note(
      id: '3',
      title: "Programmation C++",
      type: "TP - 2A - RT",
      teacher: "Dr. HAMDI",
      date: "13 Nov 2025",
      students: "42 étudiants",
      status: NoteStatus.pending,
    ),
  ];

  final List<Note> _publishedNotes = [
    Note(
      id: '4',
      title: "Base de données",
      type: "Examen - 2A - RT",
      teacher: "Dr. AHMED",
      date: "10 Nov 2025",
      students: "45 étudiants",
      status: NoteStatus.published,
    ),
  ];

  List<Note> get pendingNotes => _pendingNotes;
  List<Note> get publishedNotes => _publishedNotes;

  int get pendingCount => _pendingNotes.length;
  int get publishedCount => _publishedNotes.length;

  void publishNote(String noteId) {
    final noteIndex = _pendingNotes.indexWhere((note) => note.id == noteId);
    if (noteIndex != -1) {
      final note = _pendingNotes.removeAt(noteIndex);
      _publishedNotes.insert(0, Note(
        id: note.id,
        title: note.title,
        type: note.type,
        teacher: note.teacher,
        date: note.date,
        students: note.students,
        status: NoteStatus.published,
      ));
      notifyListeners();
    }
  }

  void verifyNote(String noteId) {
    // Logique pour vérifier une note
    notifyListeners();
  }
}
