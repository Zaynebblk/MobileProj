import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes/notes_viewmodel.dart';
import '../../widgets/notes/status_card.dart';
import '../../widgets/notes/note_card.dart';
import '../../widgets/notes/recent_note_card.dart';

class PublierNotesPage extends StatelessWidget {
  const PublierNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xfffdf7ef),
        appBar: AppBar(
          backgroundColor: const Color(0xffff5f6e),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Publier Notes",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Consumer<NotesViewModel>(
          builder: (context, viewModel, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER CARD STATUS ---
                  Row(
                    children: [
                      StatusCard(
                        number: viewModel.pendingCount.toString(),
                        label: "En attente",
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 10),
                      StatusCard(
                        number: viewModel.publishedCount.toString(),
                        label: "Publiées",
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Notes prêtes à publier",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 15),

                  // --- LISTE DES NOTES À PUBLIER ---
                  ...viewModel.pendingNotes.map((note) {
                    return NoteCard(
                      note: note,
                      onPublish: () => viewModel.publishNote(note.id),
                      onVerify: () => viewModel.verifyNote(note.id),
                    );
                  }),

                  const SizedBox(height: 25),
                  const Text(
                    "Récemment publiées",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),

                  // --- NOTES RÉCEMMENT PUBLIÉES ---
                  ...viewModel.publishedNotes.map((note) {
                    return RecentNoteCard(note: note);
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
