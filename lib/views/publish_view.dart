import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/publish_view_model.dart';
import '../models/publish_model.dart';

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  @override
  void initState() {
    super.initState();
    // Charger les données au lancement de la page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PublishViewModel>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Couleurs extraites de l'image
    final pinkColor = const Color(0xFFE91E63); // Le rose du header
    final creamBg = const Color(0xFFFFF8E1); // Le fond crème
    final orangeBtn = const Color(0xFFE65100); // L'orange des boutons

    return Scaffold(
      backgroundColor: creamBg,
      body: Consumer<PublishViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // --- 1. HEADER ROSE ---
              Container(
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0), // Plat selon l'image
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
                            Text(
                              "Publier Notes",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Gestion de publication",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Les deux cartes statistiques en haut
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

              // --- 2. LISTE SCROLLABLE ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Notes prêtes à publier", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      
                      // Liste des examens en attente
                      ...vm.pendingExams.map((exam) => _buildExamCard(exam, orangeBtn)).toList(),

                      const SizedBox(height: 20),
                      const Text("Récemment publiées", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      // Petite liste pour les publiés (simplifiée)
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

  // Widget: Carte Statistique du haut (3 En attente)
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

  // Widget: Carte principale (Réseaux Informatiques...)
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
          // Info row (Prof, Date, Students)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _iconText(Icons.person, exam.professor),
              _iconText(Icons.calendar_today, exam.date),
              _iconText(Icons.people, "${exam.studentCount} étudiants"),
            ],
          ),
          const SizedBox(height: 20),
          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
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
                  onPressed: () {},
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

  // Widget: Petite carte pour "Récemment publiées"
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