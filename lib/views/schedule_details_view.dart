import 'package:flutter/material.dart';
import '../models/schedule_model.dart'; // Assurez-vous que l'import est bon

class ScheduleDetailsView extends StatefulWidget {
  final ScheduleClass scheduleClass;

  const ScheduleDetailsView({super.key, required this.scheduleClass});

  @override
  State<ScheduleDetailsView> createState() => _ScheduleDetailsViewState();
}

class _ScheduleDetailsViewState extends State<ScheduleDetailsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _days.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final pinkHeader = const Color(0xFFE91E63);
    final orangeBtn = const Color(0xFFE65100);
    final creamBg = const Color(0xFFFFF8E1);

    bool isPublished = widget.scheduleClass.status == "publié";

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.scheduleClass.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.edit, color: Colors.white), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: orangeBtn,
          indicatorWeight: 4,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabs: _days.map((day) => Tab(text: day)).toList(),
        ),
      ),
      body: Column(
        children: [
          // BANDEAU D'ÉTAT
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isPublished ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPublished ? Icons.check_circle : Icons.warning_amber_rounded,
                    color: isPublished ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPublished ? "Planning Publié" : "En attente de validation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isPublished ? Colors.green : Colors.orange[800],
                        ),
                      ),
                      const Text("Dernière modif: Il y a 2 heures", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // CONTENU DES ONGLETS (COURS)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _days.map((day) => _buildDaySchedule(day)).toList(),
            ),
          ),
        ],
      ),
      
      // BOUTONS D'ACTION FLOTTANTS (SI NON PUBLIÉ)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("SUPPRIMER", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Planning validé et publié !")));
                   Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: orangeBtn,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  isPublished ? "MODIFIER" : "VALIDER & PUBLIER", 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySchedule(String day) {
    // Simulation de données
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _courseCard("08:00 - 10:00", "Mathématiques", "Salle 204", "Mr. Ben Ali", Colors.blue),
        _courseCard("10:15 - 12:15", "Algorithmique", "Labo 3", "Mme. Tounsi", Colors.purple),
        if (day == "Mercredi") 
           Center(child: Padding(padding: EdgeInsets.all(40), child: Text("Après-midi libre", style: TextStyle(color: Colors.grey)))),
        if (day != "Mercredi")
        _courseCard("14:00 - 16:00", "Physique", "Amphi A", "Mr. Kallel", Colors.orange),
      ],
    );
  }

  Widget _courseCard(String time, String subject, String room, String prof, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time.split(" - ")[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(time.split(" - ")[1], style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 20),
          Container(width: 1, height: 40, color: Colors.grey[300]),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(room, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 15),
                    Icon(Icons.person, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(prof, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}