import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/room_view_model.dart';
import '../models/room_model.dart';
import 'add_room_view.dart'; // IMPORT DE LA NOUVELLE PAGE

class RoomView extends StatefulWidget {
  const RoomView({super.key});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RoomViewModel>(context, listen: false).fetchRooms();
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
            Text("Gestion des Salles", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Disponibilité & Maintenance", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      body: Consumer<RoomViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // STATS
                Row(
                  children: [
                    Expanded(child: _statCard(vm.totalRooms, "Total", Colors.blue)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.availableRooms, "Libres", Colors.green)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.maintenanceRooms, "Travaux", Colors.red)),
                  ],
                ),
                const SizedBox(height: 25),

                // BARRE D'ACTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Liste des locaux", style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                    
                    // --- BOUTON AJOUTER MODIFIÉ ---
                    ElevatedButton.icon(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddRoomView()),
                        );
                      },
                      icon: const Icon(Icons.add, size: 18, color: Colors.white),
                      label: const Text("Ajouter", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    )
                  ],
                ),
                const SizedBox(height: 15),

                // LISTE DES SALLES
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.rooms.length,
                  itemBuilder: (ctx, i) => _roomCard(vm.rooms[i]),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        children: [
          Text("$count", style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _roomCard(Room item) {
    Color statusColor;
    Color statusBg;

    if (item.status == "Libre") {
      statusColor = Colors.green;
      statusBg = Colors.green.withOpacity(0.1);
    } else if (item.status == "Occupée") {
      statusColor = Colors.red;
      statusBg = Colors.red.withOpacity(0.1);
    } else {
      statusColor = Colors.orange;
      statusBg = Colors.orange.withOpacity(0.1);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(
        children: [
          // Icone Salle
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(item.type == "Amphi" ? Icons.theater_comedy : Icons.meeting_room, color: Colors.teal),
          ),
          const SizedBox(width: 15),
          
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.people_alt_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${item.capacity} places", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 10),
                    if (item.hasProjector) ...[
                      const Icon(Icons.videocam_outlined, size: 14, color: Colors.blueGrey),
                      const SizedBox(width: 4),
                      const Text("DataShow", style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                    ]
                  ],
                ),
              ],
            ),
          ),
          
          // Status Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
            child: Text(item.status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}