import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/rattrapage_view_model.dart';
import '../models/rattrapage_model.dart';
import 'create_rattrapage_view.dart'; // Page de création
import 'edit_rattrapage_view.dart';   // Page de modification (Nouvelle)

class RattrapageView extends StatefulWidget {
  const RattrapageView({super.key});

  @override
  State<RattrapageView> createState() => _RattrapageViewState();
}

class _RattrapageViewState extends State<RattrapageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RattrapageViewModel>(context, listen: false).loadSessions();
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
            Text("Rattrapages", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Planification des sessions", style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
      body: Consumer<RattrapageViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // BOUTON AJOUTER
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orangeBtn,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      shadowColor: orangeBtn.withOpacity(0.4),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateRattrapageView()));
                    }, 
                    icon: const Icon(Icons.add_circle, color: Colors.white),
                    label: const Text("Planifier une session de rattrapage", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                
                const SizedBox(height: 20),

                // CARTES STATS
                Row(
                  children: [
                    Expanded(child: _statCard(vm.sessionsCount.toString(), "Sessions", Colors.orange)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.inscritsCount.toString(), "Inscrits", Colors.blue)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.enAttenteCount.toString(), "En attente", Colors.red)),
                  ],
                ),
                const SizedBox(height: 25),

                const Text("Sessions planifiées", style: TextStyle(color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),

                // LISTE DES SESSIONS
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), 
                  shrinkWrap: true,
                  itemCount: vm.sessions.length,
                  itemBuilder: (context, index) {
                    return _sessionCard(context, vm.sessions[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // --- CARTE SESSION MISE A JOUR ---
  Widget _sessionCard(BuildContext context, RattrapageSession session) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_today, color: Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(session.subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(session.professor, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoRow(Icons.calendar_month, session.date),
              _infoRow(Icons.location_on, session.room),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoRow(Icons.access_time, session.time),
              _infoRow(Icons.group, "${session.registered}/${session.capacity}"),
            ],
          ),
          
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: session.progress,
              backgroundColor: Colors.grey[200],
              color: Colors.deepOrange,
              minHeight: 6,
            ),
          ),
          
          const SizedBox(height: 15),
          
          // --- CHANGEMENT ICI : BOUTON UNIQUE MODIFIER ---
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Navigation vers la page d'édition en passant la session
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => EditRattrapageView(session: session))
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.deepOrange),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12)
              ),
              icon: const Icon(Icons.edit, color: Colors.deepOrange, size: 18),
              label: const Text("MODIFIER & GÉRER", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey[800], fontSize: 13)),
      ],
    );
  }
}