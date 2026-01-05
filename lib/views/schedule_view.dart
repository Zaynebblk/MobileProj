import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/schedule_view_model.dart';
import '../models/schedule_model.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScheduleViewModel>(context, listen: false).loadData();
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
            Text("Emplois du temps", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Gestion des emplois", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      body: Consumer<ScheduleViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STATS
                Row(
                  children: [
                    Expanded(child: _statCard(vm.classesCount, "Classes", Colors.purple)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.publishedCount, "Publiés", Colors.green)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.professorCount, "Professeurs", Colors.blue)),
                  ],
                ),
                const SizedBox(height: 25),

                // SECTION EMPLOIS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Emplois par classe", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18, color: Colors.white),
                      label: const Text("Nouveau", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    )
                  ],
                ),
                const SizedBox(height: 15),

                // LISTE DES CLASSES
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.classes.length,
                  itemBuilder: (ctx, i) => _classCard(vm.classes[i]),
                ),

                const SizedBox(height: 25),

                // SECTION PROFS
                const Text("Disponibilité professeurs", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),

                // LISTE DES PROFS
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.professors.length,
                  itemBuilder: (ctx, i) => _profCard(vm.professors[i]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(int count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        children: [
          Text("$count", style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _classCard(ScheduleClass item) {
    bool isPublished = item.status == "publié";
    Color statusColor = isPublished ? Colors.green : Colors.amber;
    Color statusBg = isPublished ? Colors.green.withOpacity(0.1) : Colors.amber.withOpacity(0.1);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.calendar_today, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(5)),
                          child: Text(item.status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(item.subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 16, color: Color(0xFFE65100)),
                  label: const Text("Modifier", style: TextStyle(color: Color(0xFFE65100))),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFE65100)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Voir emploi", style: TextStyle(color: Colors.black87)),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profCard(ProfessorAvailability prof) {
    Color statusColor = prof.status == "complet" ? Colors.red : Colors.green;
    Color statusBg = prof.status == "complet" ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(prof.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(5)),
                child: Text(prof.status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _infoChip("Heures/semaine", "${prof.hoursPerWeek}h"),
              const SizedBox(width: 20),
              _infoChip("Nombre de cours", "${prof.coursesCount}"),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}