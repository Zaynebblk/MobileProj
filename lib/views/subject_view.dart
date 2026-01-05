import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/subject_view_model.dart';
import '../models/subject_model.dart';

class SubjectView extends StatefulWidget {
  const SubjectView({super.key});

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SubjectViewModel>(context, listen: false).loadSubjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinkHeader = const Color(0xFFE91E63);
    final orangeBtn = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Gestion des Matières", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Liste des modules et coefficients", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      body: Consumer<SubjectViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // STATS
                Row(
                  children: [
                    Expanded(child: _statCard(vm.totalSubjects.toString(), "Matières", Colors.blue)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.totalCoeff.toString(), "Total Coeff", Colors.purple)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.semester1Count.toString(), "Semestre 1", Colors.orange)),
                  ],
                ),
                const SizedBox(height: 25),

                // BARRE D'ACTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Liste des cours", style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18, color: Colors.white),
                      label: const Text("Ajouter", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    )
                  ],
                ),
                const SizedBox(height: 15),

                // LISTE DES MATIERES
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.subjects.length,
                  itemBuilder: (ctx, i) => _subjectCard(vm.subjects[i]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _subjectCard(Subject item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icone
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.menu_book_rounded, color: Colors.indigo),
          ),
          const SizedBox(width: 15),
          
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                      child: Text("Coeff: ${item.coeff}", style: const TextStyle(color: Colors.deepOrange, fontSize: 11, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text("${item.code}  •  ${item.professor}", style: const TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text("Semestre ${item.semester}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 15),
                    Icon(Icons.class_, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(item.type, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          
          // Menu 3 points
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          )
        ],
      ),
    );
  }
}