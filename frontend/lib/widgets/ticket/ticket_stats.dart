import 'package:flutter/material.dart';

class TicketStats extends StatelessWidget {
  final int nouveaux;
  final int enCours;
  final int resolus;

  const TicketStats({
    super.key,
    required this.nouveaux,
    required this.enCours,
    required this.resolus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          _statCard(nouveaux.toString(), "Nouveaux"),
          const SizedBox(width: 10),
          _statCard(enCours.toString(), "En cours"),
          const SizedBox(width: 10),
          _statCard(resolus.toString(), "Résolus"),
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
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
