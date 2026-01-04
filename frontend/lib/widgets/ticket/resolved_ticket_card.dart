import 'package:flutter/material.dart';
import '../../models/ticket.dart';

class ResolvedTicketCard extends StatelessWidget {
  final Ticket ticket;

  const ResolvedTicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
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
            ),
          ],
        ),
      ),
    );
  }
}
