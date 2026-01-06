import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/publish_view_model.dart';
import '../models/publish_model.dart';

// Imports des sous-pages
import 'publish_form_view.dart';
import 'verify_view.dart'; // <--- NOUVEL IMPORT

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PublishViewModel>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinkColor = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: creamBg,
      body: Consumer<PublishViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // --- HEADER ---
              Container(
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Publier Notes", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("Gestion de publication", style: TextStyle(color: Colors.white70, fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildTopStatCard(vm.pendingCount.toString(), "En attente", Colors.orange)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTopStatCard(vm.publishedCount.toString(), "Publiées", Colors.teal)),
                      ],
                    )
                  ],
                ),
              ),

              // --- LISTE ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bouton Nouvelle Publication
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishFormView()));
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          label: const Text("NOUVELLE PUBLICATION MANUELLE"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: pinkColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                            side: BorderSide(color: pinkColor),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text("Notes prêtes à publier", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      
                      ...vm.pendingExams.map((exam) => _buildExamCard(exam, orangeBtn)).toList(),

                      const SizedBox(height: 20),
                      const Text("Récemment publiées", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      ...vm.publishedExams.map((exam) => _buildPublishedCard(exam)).toList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopStatCard(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildExamCard(ExamSession exam, Color btnColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.assignment_outlined, color: Colors.orange),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exam.subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("${exam.type} • ${exam.group}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              if (exam.isReady)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(5)),
                  child: const Text("Prêt", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _iconText(Icons.person, exam.professor),
              _iconText(Icons.calendar_today, exam.date),
              _iconText(Icons.people, "${exam.studentCount} étudiants"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishFormView()));
                  },
                  icon: const Icon(Icons.upload, size: 18),
                  label: const Text("Publier"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  // --- MODIFICATION ICI : Navigation vers VerifyView ---
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyView(exam: exam)));
                  },
                  child: const Text("Vérifier"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPublishedCard(ExamSession exam) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.green[50], shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.green, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exam.subject, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Publié le ${exam.date} • ${exam.group}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}