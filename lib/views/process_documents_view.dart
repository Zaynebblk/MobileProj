import 'package:flutter/material.dart';

class ProcessDocumentsView extends StatefulWidget {
  const ProcessDocumentsView({super.key});

  @override
  State<ProcessDocumentsView> createState() => _ProcessDocumentsViewState();
}

class _ProcessDocumentsViewState extends State<ProcessDocumentsView> {
  final pinkHeader = const Color(0xFFE91E63);
  final creamBg = const Color(0xFFFFF8E1);

  // Données simulées pour les documents en attente
  final List<Map<String, String>> _pendingDocs = [
    {
      "student": "Amine Ben Ali",
      "type": "Attestation de présence",
      "date": "05 Jan 2024",
      "id": "1"
    },
    {
      "student": "Sarah Mnsari",
      "type": "Convention de Stage",
      "date": "06 Jan 2024",
      "id": "2"
    },
    {
      "student": "Karim Jlassi",
      "type": "Relevé de notes",
      "date": "06 Jan 2024",
      "id": "3"
    },
  ];

  void _handleAction(int index, bool isApproved) {
    // Simulation du traitement
    String message = isApproved ? "Document signé numériquement !" : "Demande rejetée.";
    Color color = isApproved ? Colors.green : Colors.red;

    setState(() {
      _pendingDocs.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color, duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        backgroundColor: pinkHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Traitement des demandes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: _pendingDocs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 20),
                  Text("Aucune demande en attente", style: TextStyle(color: Colors.grey.shade600, fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pendingDocs.length,
              itemBuilder: (context, index) {
                final item = _pendingDocs[index];
                return _buildTaskCard(item, index);
              },
            ),
    );
  }

  Widget _buildTaskCard(Map<String, String> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange.withOpacity(0.2),
                child: Text(item["student"]![0], style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item["type"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("Demandé par : ${item["student"]}", style: const TextStyle(color: Colors.grey)),
                    Text("Date : ${item["date"]}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _handleAction(index, false),
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text("Rejeter", style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _handleAction(index, true),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text("Signer", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}