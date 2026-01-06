import 'package:flutter/material.dart';
import '../view_models/ticket_view_model.dart'; // Gardez votre import de modèle si nécessaire

// Import de la page de détail pour la navigation
import 'ticket_detail_view.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  // --- DONNÉES SIMULÉES (MOCK) ---
  final List<TicketData> mockTickets = [
    TicketData(
      id: "REQ-8821",
      studentName: "Amine Ben Salah",
      studentClass: "INDP2-B",
      type: "Rectification Note", // Sera Orange
      subject: "Erreur note DS Cloud Computing",
      date: "Auj. 10:30",
      message: "Bonjour, j'ai reçu 08/20 alors que j'ai bien rendu ma copie.",
      hasAttachment: true,
    ),
    TicketData(
      id: "REQ-8822",
      studentName: "Meriem Jaziri",
      studentClass: "INDP1-A",
      type: "Attestation", // Sera Teal/Bleu
      subject: "Demande attestation de présence",
      date: "Hier 14:15",
      message: "J'ai besoin d'une attestation pour mon visa s'il vous plaît.",
    ),
    TicketData(
      id: "REQ-8823",
      studentName: "Karim Tounsi",
      studentClass: "INDP3-C",
      type: "Problème Technique", // Sera Teal/Bleu
      subject: "Accès Moodle bloqué",
      date: "24 Oct",
      message: "Je n'arrive plus à me connecter à la plateforme.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // --- PALETTE DE COULEURS EXACTE DE PUBLISHVIEW ---
    final pinkHeader = const Color(0xFFE91E63); // Le Rose du header
    final creamBg = const Color(0xFFFFF8E1);   // Le fond Crème
    final orangeBtn = const Color(0xFFE65100); // L'Orange des boutons d'action
    final orangeAccent = Colors.orange;        // Pour les stats/badges
    final tealAccent = Colors.teal;            // Pour le "bleu/vert" des stats/badges

    return Scaffold(
      backgroundColor: creamBg,
      body: Column(
        children: [
          // --- HEADER ROSE (Style Admin Moderne) ---
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              color: pinkHeader,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(color: pinkHeader.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne de navigation
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
                        Text("Gestion Tickets", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("Suivi des demandes étudiants", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),
                
                // Cartes de Stats (Mélange Orange et Teal comme PublishView)
                Row(
                  children: [
                    Expanded(child: _buildTopStatCard(mockTickets.length.toString(), "En attente", Icons.inbox, orangeAccent)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTopStatCard("12", "Traités (24h)", Icons.check_circle, tealAccent)),
                  ],
                )
              ],
            ),
          ),

          // --- LISTE DES TICKETS ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              itemCount: mockTickets.length,
              itemBuilder: (context, index) {
                final ticket = mockTickets[index];
                // On passe les couleurs d'accentuation pour les utiliser dans la carte
                return _buildTicketCard(ticket, orangeAccent, tealAccent, orangeBtn);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget Statistique (Header)
  Widget _buildTopStatCard(String count, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(count, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Carte Ticket (Item)
  Widget _buildTicketCard(TicketData ticket, Color orangeAccent, Color tealAccent, Color btnColor) {
    // Choix de la couleur d'accentuation selon le type (Orange pour urgent, Teal pour le reste)
    Color dynamicColor = ticket.type.contains("Rectification") ? orangeAccent : tealAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête : Avatar + Info + Date
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: dynamicColor.withOpacity(0.1),
                child: Text(ticket.studentName[0], style: TextStyle(color: dynamicColor, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticket.studentName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("${ticket.studentClass} • ${ticket.id}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text(ticket.date, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),

          // Badge Type (Utilise la couleur dynamique Orange ou Teal)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: dynamicColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket.type.toUpperCase(), 
                  style: TextStyle(color: dynamicColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)
                ),
              ),
              if (ticket.hasAttachment) ...[
                const Spacer(),
                const Icon(Icons.attach_file, size: 16, color: Colors.grey),
                const Text(" Pièce jointe", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]
            ],
          ),

          const SizedBox(height: 12),
          
          // Sujet et Message
          Text(ticket.subject, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
          const SizedBox(height: 6),
          Text(
            ticket.message, 
            maxLines: 2, 
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4)
          ),

          const SizedBox(height: 20),

          // Bouton Traiter (Couleur ORANGE VIF exacte du bouton "Publier")
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => TicketDetailView(ticket: ticket))
                );
              },
              icon: const Icon(Icons.edit_note, size: 20),
              label: const Text("TRAITER LA DEMANDE"),
              style: ElevatedButton.styleFrom(
                backgroundColor: btnColor, // Le orange vif 0xFFE65100
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                shadowColor: btnColor.withOpacity(0.4),
              ),
            ),
          )
        ],
      ),
    );
  }
}