import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import pour les requêtes API
import 'dart:convert'; // Import pour encoder en JSON
import 'package:flutter/foundation.dart'; // Pour kIsWeb

// --- CONFIGURATION ---
const String serverIP = "192.168.100.17"; // Ton IP
const String port = "5000";

class DemanderDocumentScreen extends StatefulWidget {
  const DemanderDocumentScreen({super.key});

  @override
  State<DemanderDocumentScreen> createState() => _DemanderDocumentScreenState();
}

class _DemanderDocumentScreenState extends State<DemanderDocumentScreen> {
  final List<String> _documentTypes = [
    'Attestation de Scolarité',
    'Relevé de Notes',
    'Certificat de Stage',
    'Autre'
  ];
  
  String? _selectedDocumentType;
  final TextEditingController _raisonController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  
  // État de chargement
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedDocumentType = _documentTypes[0]; 
  }

  @override
  void dispose() {
    _raisonController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // --- LOGIQUE D'ENVOI ---
  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:$port';
    return 'http://$serverIP:$port';
  }

  Future<void> _submitRequest() async {
    setState(() => _isSubmitting = true);

    try {
      final url = Uri.parse('${getBaseUrl()}/api/doc-requests/send');
      
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "studentId": "STUDENT_123", // Plus tard, utilise l'ID réel de l'utilisateur
          "studentName": "Etudiant Test", // Plus tard, utilise le nom réel
          "documentType": _selectedDocumentType,
          "comment": "Raison: ${_raisonController.text} | Détails: ${_detailsController.text}",
        }),
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Demande envoyée ! L'admin a été notifié."),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); 
      } else {
        throw Exception("Erreur serveur : ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color.fromARGB(255, 64, 179, 255); 
    const Color primaryRed = Color.fromARGB(255, 183, 27, 13);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text("Demander un Document", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Type de document", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildDropdownField(primaryBlue),
            const SizedBox(height: 20),

            const Text("Raison (optionnel)", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildInputField(
              controller: _raisonController,
              hintText: "Ex: Inscription master...",
              maxLines: 2,
              primaryColor: primaryBlue,
            ),
            const SizedBox(height: 20),
            
            const Text("Détails supplémentaires", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildInputField(
              controller: _detailsController,
              hintText: "Spécifiez si besoin...",
              maxLines: 4,
              primaryColor: primaryBlue,
            ),
            const SizedBox(height: 30),

            // --- BOUTON DE SOUMISSION ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isSubmitting 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Soumettre la Demande",
                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tes fonctions _buildDropdownField et _buildInputField restent identiques...
  Widget _buildDropdownField(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedDocumentType,
          icon: Icon(Icons.arrow_drop_down, color: primaryColor),
          items: _documentTypes.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? newValue) => setState(() => _selectedDocumentType = newValue),
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String hintText, required int maxLines, required Color primaryColor}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: primaryColor, width: 2)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}