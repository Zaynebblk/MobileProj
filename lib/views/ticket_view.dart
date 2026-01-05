import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/ticket_view_model.dart';
import '../models/ticket_model.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketViewModel>(context, listen: false).loadTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pinkColor = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);

    return Scaffold(
      backgroundColor: creamBg,
      body: Consumer<TicketViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // --- HEADER ROSE ---
              Container(
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
                decoration: BoxDecoration(color: pinkColor),
                child: Column(
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
                            Text("Tickets", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("Gestion des demandes", style: TextStyle(color: Colors.white70, fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    // STATS ROW (3 cartes)
                    Row(
                      children: [
                        Expanded(child: _buildTopStatCard(vm.countNouveaux.toString(), "Nouveaux", Colors.blue)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTopStatCard(vm.countEnCours.toString(), "En cours", Colors.orange)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTopStatCard(vm.countResolus.toString(), "Résolus", Colors.green)),
                      ],
                    )
                  ],
                ),
              ),

              // --- LISTE DES TICKETS ---
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.tickets.length,
                  itemBuilder: (context, index) {
                    return _buildTicketCard(vm.tickets[index]);
                  },
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

  Widget _buildTicketCard(Ticket ticket) {
    // Logique pour les couleurs et icônes
    Color iconBgColor;
    IconData iconData;
    Color statusColor;
    
    if (ticket.status == "resolu") {
      iconBgColor = Colors.green[50]!;
      iconData = Icons.check;
      statusColor = Colors.green;
    } else if (ticket.status == "en cours") {
      iconBgColor = Colors.orange[50]!;
      iconData = Icons.access_time;
      statusColor = Colors.orange;
    } else {
      iconBgColor = Colors.blue[50]!;
      iconData = Icons.info_outline;
      statusColor = Colors.blue;
    }

    // Couleur du badge priorité
    Color priorityColor = ticket.priority == "haute" ? Colors.red : 
                          ticket.priority == "moyenne" ? Colors.orange : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icone à gauche
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(8)),
                child: Icon(iconData, color: statusColor),
              ),
              const SizedBox(width: 12),
              
              // Contenu à droite
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ligne ID et Badges
                    Row(
                      children: [
                        Text(ticket.id, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        _buildBadge(ticket.priority.toUpperCase(), priorityColor.withOpacity(0.1), priorityColor),
                        const SizedBox(width: 5),
                        _buildBadge(ticket.status, statusColor.withOpacity(0.1), statusColor),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(ticket.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    // User, Categorie, Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _iconText(Icons.person, ticket.userName),
                        _iconText(Icons.folder, ticket.category),
                        _iconText(Icons.calendar_today, ticket.date),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          // Boutons Traiter / Voir détails
          if (ticket.status != "resolu") 
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65100),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Traiter", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Voir détails", style: TextStyle(color: Colors.black87)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: TextStyle(color: textCol, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}