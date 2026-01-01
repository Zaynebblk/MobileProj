import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // 1. Ajout de l'import http
import 'dart:convert'; // Pour encoder en JSON
import 'package:flutter/foundation.dart'; // Pour kIsWeb

class NouveauMessageScreen extends StatefulWidget {
  const NouveauMessageScreen({super.key});

  @override
  State<NouveauMessageScreen> createState() => _NouveauMessageScreenState();
}

class _NouveauMessageScreenState extends State<NouveauMessageScreen> {
  String? _selectedRole = 'Professeur'; 
  final List<String> _roles = ['Professeur', 'Administrateur'];

  final TextEditingController _destinataireController = TextEditingController();
  final TextEditingController _objetController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Indicateur de chargement pendant l'envoi
  bool _isLoading = false;

  @override
  void dispose() {
    _destinataireController.dispose();
    _objetController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // --- NOUVELLE LOGIQUE D'ENVOI RÉEL ---
  Future<void> _sendMessage() async {
    // Vérification simple
    if (_objetController.text.isEmpty || _messageController.text.isEmpty) {
      _showSnackBar("L'objet et le message sont obligatoires", Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Remplace par TON adresse IP (ipconfig dans le terminal)
      const String serverIP = "192.168.100.17"; 
      final baseUrl = kIsWeb ? 'http://localhost:5000' : 'http://$serverIP:5000';
      final url = Uri.parse('$baseUrl/api/messagees/envoyer');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "destinataire": _selectedRole, // 'Professeur' ou 'Administrateur'
          "specificName": _destinataireController.text, // Nom optionnel
          "objet": _objetController.text,
          "contenu": _messageController.text,
        }),
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        _showSnackBar("Message envoyé avec succès !", Colors.green);
        Navigator.pop(context); 
      } else {
        throw Exception("Erreur serveur : ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar("Erreur de connexion : $e", Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          "Nouveau Message",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // On affiche un cercle de chargement si l'envoi est en cours
          _isLoading 
            ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(color: Colors.white))
            : IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildRoleAndDestinataireField(primaryColor),
            const SizedBox(height: 15),
            _buildInputField(
              controller: _objetController,
              labelText: "Objet",
              hintText: "Sujet du message",
              icon: Icons.subject,
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 15),
            _buildMessageBodyField(
              controller: _messageController,
              primaryColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  // Tes widgets UI (ils restent identiques, juste connectés à l'état)
  Widget _buildRoleAndDestinataireField(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.person_outline, color: primaryColor),
          const SizedBox(width: 10),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedRole,
              items: _roles.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: (String? newValue) => setState(() => _selectedRole = newValue),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _destinataireController,
              decoration: const InputDecoration(
                hintText: "Nom (optionnel)",
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String labelText, required String hintText, required IconData icon, required Color primaryColor}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildMessageBodyField({required TextEditingController controller, required Color primaryColor}) {
    return TextField(
      controller: controller,
      maxLines: 12,
      decoration: InputDecoration(
        labelText: "Message",
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}