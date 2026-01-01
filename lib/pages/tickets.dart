import 'package:flutter/material.dart';
import '../models/ticket.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  // 🔥 Liste dynamique (sera remplacée par Firebase / API)
  final List<Ticket> tickets = [
    Ticket(
      id: "#2024-156",
      titre: "Problème de connexion WiFi",
      auteur: "MADDAHI Manel",
      service: "Technique",
      date: "16 Nov 2025",
      priorite: "haute",
    ),
    Ticket(
      id: "#2024-155",
      titre: "Demande de relevé de notes",
      auteur: "BEN SALEM Youssef",
      service: "Administratif",
      date: "15 Nov 2025",
      priorite: "moyenne",
      statut: "en cours",
    ),
    Ticket(
      id: "#2024-154",
      titre: "Modification emploi du temps",
      auteur: "Dr. BENALI",
      service: "Scolarité",
      date: "15 Nov 2025",
      priorite: "haute",
    ),
    Ticket(
      id: "#2024-153",
      titre: "Accès bibliothèque",
      auteur: "AHMED Fatma",
      service: "Services",
      date: "14 Nov 2025",
      priorite: "basse",
      statut: "resolu",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final nouveaux = tickets.where((t) => t.statut == "nouveau").length;
    final enCours = tickets.where((t) => t.statut == "en cours").length;
    final resolus = tickets.where((t) => t.statut == "resolu").length;

    return Scaffold(
      backgroundColor: const Color(0xffFFF1DC),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2386A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tickets",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Text("Gestion des demandes",
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            _buildStats(nouveaux, enCours, resolus),
            const SizedBox(height: 20),

            // 🔥 TICKETS ACTIFS
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tickets
                  .where((t) => t.statut != "resolu")
                  .length,
              itemBuilder: (context, index) {
                final ticket = tickets
                    .where((t) => t.statut != "resolu")
                    .toList()[index];
                return _ticketCard(ticket);
              },
            ),

            const SizedBox(height: 10),

            // ✅ TICKETS RÉSOLUS
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  tickets.where((t) => t.statut == "resolu").length,
              itemBuilder: (context, index) {
                final ticket =
                    tickets.where((t) => t.statut == "resolu").toList()[index];
                return _resolvedCard(ticket);
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // STATS
  // -------------------------
  Widget _buildStats(int nouveau, int enCours, int resolu) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          _statCard(nouveau.toString(), "Nouveaux"),
          const SizedBox(width: 10),
          _statCard(enCours.toString(), "En cours"),
          const SizedBox(width: 10),
          _statCard(resolu.toString(), "Résolus"),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange)),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // TICKET CARD
  // -------------------------
  Widget _ticketCard(Ticket ticket) {
    final Color priorityColor = ticket.priorite == "haute"
        ? Colors.red
        : ticket.priorite == "moyenne"
            ? Colors.orange
            : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: priorityColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.info, color: priorityColor),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticket.id,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey)),
                      Text(ticket.titre,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                _badge(ticket.priorite, priorityColor),
                const SizedBox(width: 5),
                _badge(ticket.statut,
                    ticket.statut == "nouveau"
                        ? Colors.blue
                        : Colors.orange),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, size: 14, color: Colors.grey),
                const SizedBox(width: 5),
                Text(ticket.auteur, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 10),
                const Icon(Icons.work, size: 14, color: Colors.grey),
                const SizedBox(width: 5),
                Text(ticket.service, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 10),
                const Icon(Icons.calendar_today,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 5),
                Text(ticket.date, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      setState(() {
                        ticket.statut = "en cours";
                      });
                    },
                    child: const Text("Traiter"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {},
                    child: const Text("Voir détails"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // -------------------------
  // RESOLVED CARD
  // -------------------------
  Widget _resolvedCard(Ticket ticket) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xffDFF5E3),
              child: Icon(Icons.check, color: Colors.green),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "${ticket.titre}\n${ticket.auteur} · ${ticket.service} · ${ticket.date}",
                style: const TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }

  // -------------------------
  // BADGE
  // -------------------------
  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: color),
      ),
    );
  }
}
