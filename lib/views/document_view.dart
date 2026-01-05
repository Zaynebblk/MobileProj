import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/document_view_model.dart';
import '../models/document_model.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({super.key});

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DocumentViewModel>(context, listen: false).fetchDocuments();
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
            Text("Documents Admin", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Conventions, Attestations...", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
      body: Consumer<DocumentViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // STATS
                Row(
                  children: [
                    Expanded(child: _statCard(vm.totalDocs, "Total", Colors.blue)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.pendingDocs, "En attente", Colors.orange)),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard(vm.signedDocs, "Signés", Colors.green)),
                  ],
                ),
                const SizedBox(height: 25),

                // BARRE D'ACTION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Demandes récentes", style: TextStyle(color: Colors.brown, fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file, size: 18, color: Colors.white),
                      label: const Text("Traiter", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: orangeBtn, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    )
                  ],
                ),
                const SizedBox(height: 15),

                // LISTE DES DOCUMENTS
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.documents.length,
                  itemBuilder: (ctx, i) => _docCard(vm.documents[i]),
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

  Widget _docCard(DocumentModel item) {
    Color statusColor;
    IconData statusIcon;
    
    if (item.status == "Signé") {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
    } else if (item.status == "Rejeté") {
      statusColor = Colors.red;
      statusIcon = Icons.cancel_outlined;
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_empty;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(
        children: [
          // Icone Fichier
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.description, color: Colors.blueGrey),
          ),
          const SizedBox(width: 15),
          
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text("Étudiant: ${item.studentName}", style: const TextStyle(color: Colors.black87, fontSize: 13)),
                const SizedBox(height: 4),
                Text("${item.date} • ${item.type}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          
          // Status Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Icon(statusIcon, size: 14, color: statusColor),
                const SizedBox(width: 4),
                Text(item.status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}