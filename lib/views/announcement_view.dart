import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/announcement_view_model.dart';
import '../models/announcement_model.dart';

class AnnouncementView extends StatefulWidget {
  const AnnouncementView({super.key});

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnnouncementViewModel>(context, listen: false).loadData();
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
            Text("Gestion Annonces", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Communication interne", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      body: Consumer<AnnouncementViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // STATS
                Row(
                  children: [
                    Expanded(child: _statCard(vm.totalAnnouncements, "Total", Colors.blue)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.activeCount, "Actives", Colors.green)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.viewsCount, "Vues", Colors.purple)),
                  ],
                ),
                const SizedBox(height: 25),

                // BARRE D'ACTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Historique", style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18, color: Colors.white),
                      label: const Text("Créer", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    )
                  ],
                ),
                const SizedBox(height: 15),

                // LISTE DES ANNONCES
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.announcements.length,
                  itemBuilder: (ctx, i) => _annonceCard(vm.announcements[i]),
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

  Widget _annonceCard(Announcement item) {
    Color statusColor = item.status == "Publié" ? Colors.green : (item.status == "Brouillon" ? Colors.grey : Colors.amber);
    Color statusBg = statusColor.withOpacity(0.1);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.pink.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.campaign, color: Colors.pink),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(5)),
                      child: Text(item.status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(item.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(item.audience, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 15),
                    Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text("${item.views}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}