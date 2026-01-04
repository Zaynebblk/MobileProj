import 'package:flutter/material.dart';

class AdminStatsCard extends StatelessWidget {
  const AdminStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _SingleStat(value: "15", label: "Tickets"),
          _SingleStat(value: "342", label: "Utilisateurs"),
          _SingleStat(value: "8", label: "Rattrapages"),
        ],
      ),
    );
  }
}

class _SingleStat extends StatelessWidget {
  final String value;
  final String label;

  const _SingleStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
