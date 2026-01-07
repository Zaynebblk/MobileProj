import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class PublierNotesPage extends StatelessWidget {
  const PublierNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf7ef),
      appBar: AppBar(
        backgroundColor: const Color(0xffff5f6e),
        elevation: 0,
        title: const Text(
          "Publier Notes",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// --- HEADER CARD STATUS (3 en attente / 1 publiées) ---
            Row(
              children: [
                _statusCard("3", "En attente", Colors.deepOrange),
                const SizedBox(width: 10),
                _statusCard("1", "Publiées", Colors.green),
              ],
            ),

            const SizedBox(height: 25),
            const Text("Notes prêtes à publier",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

            const SizedBox(height: 15),

            /// --- LISTE DES NOTES À PUBLIER ---
            _noteCard(
              title: "Réseaux informatiques",
              type: "Examen final - 2A - RT",
              teacher: "Dr. BENALI Ahmed",
              date: "15 Nov 2025",
              students: "45 étudiants",
            ),

            _noteCard(
              title: "Mathématiques",
              type: "Contrôle continu - 2A - RT",
              teacher: "Dr. TRABELSI",
              date: "14 Nov 2025",
              students: "45 étudiants",
            ),

            _noteCard(
              title: "Programmation C++",
              type: "TP - 2A - RT",
              teacher: "Dr. HAMDI",
              date: "13 Nov 2025",
              students: "42 étudiants",
            ),

            const SizedBox(height: 25),
            const Text("Récemment publiées",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

            const SizedBox(height: 12),

            /// --- RECEMMENT PUBLIÉE ---
            _recentCard(
              title: "Base de données",
              date: "10 Nov 2025",
              students: "45 étudiants",
            )
          ],
        ),
      ),
    );
  }

  /// ---------------------------------------------------------------------------
  /// Widget : Carte des statistiques haut (3 en attente / 1 publiées)
  Widget _statusCard(String number, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),

              blurRadius: 7, spreadRadius: 1, offset: Offset(0, 3)
            )
          ],
        ),
        child: Column(
          children: [
            Text(number,
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 5),
            Text(label,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  /// ---------------------------------------------------------------------------
  /// Widget : Carte de note prête à publier
  Widget _noteCard({
    required String title,
    required String type,
    required String teacher,
    required String date,
    required String students,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 7,
              offset: const Offset(0, 3))
        ],
      ),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        /// --- TITRE ---
        Row(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20)),
              child: Text("Prêt",
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),

        const SizedBox(height: 5),
        Text(type, style: TextStyle(color: Colors.grey[700])),

        const SizedBox(height: 10),

        Row(
          children: [
            const Icon(Iconsax.teacher, size: 18, color: Colors.orange),
            const SizedBox(width: 6),
            Text(teacher),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            const Icon(Icons.calendar_month,
                size: 18, color: Colors.deepPurple),
            const SizedBox(width: 6),
            Text(date),
            const Spacer(),
            const Icon(Icons.people_alt, size: 18, color: Colors.deepPurple),
            const SizedBox(width: 6),
            Text(students),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("Publier"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("Vérifier"),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  /// ---------------------------------------------------------------------------
  /// Widget : Carte récemment publiée
  Widget _recentCard({
    required String title,
    required String date,
    required String students,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("2A - RT  •  Publié le $date"),
              Text(students),
            ],
          ),
        ],
      ),
    );
  }
}
