import 'package:flutter/material.dart';

class VoirDocumentPage extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String description;

  const VoirDocumentPage({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
      ),

      body: Column(
        children: [
          // ---- DOCUMENT PREVIEW ----
          Container(
            height: 260,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.picture_as_pdf, size: 70, color: Colors.red),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Par : $author",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  Text(
                    "Ajouté le : $date",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // ---- DOWNLOAD BUTTON ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.download),
              label: const Text(
                "Télécharger",
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                // lien vers le fichier PDF ou autre
              },
            ),
          ),
        ],
      ),
    );
  }
}
