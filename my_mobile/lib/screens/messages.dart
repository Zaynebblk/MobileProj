import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // Pour kIsWeb
import 'nmessage.dart'; // Assurez-vous que ce fichier existe pour la navigation

// --- MODÈLE ---
class AppMessage {
  final String id;
  final String sender;
  final String role;
  final String preview;
  final String time;
  final int unread;

  AppMessage({
    required this.id,
    required this.sender,
    required this.role,
    required this.preview,
    required this.time,
    required this.unread,
  });

  factory AppMessage.fromJson(Map<String, dynamic> json) {
    return AppMessage(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? 'Inconnu',
      role: json['role'] ?? '',
      preview: json['preview'] ?? '',
      time: json['time'] ?? '',
      unread: json['unread'] ?? 0,
    );
  }
}

// --- ÉCRAN (STATEFUL) ---
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<AppMessage> messagesList = [];
  bool isLoading = true;

  // URL API
  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:5000';
    return 'http://10.0.2.2:5000';
  }

  // Récupération des messages
  Future<void> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse('${getBaseUrl()}/api/messages'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          messagesList = data.map((json) => AppMessage.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erreur de chargement');
      }
    } catch (e) {
      print("Erreur : $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // ---- HEADER ESPACE (Gardé vide comme votre code) ----
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                  ),

                  // const SizedBox(height: 20), // Optionnel selon votre goût

                  // ---- LISTE DES MESSAGES DYNAMIQUES ----
                  if (messagesList.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Aucun message."),
                    ),

                  // On génère les cartes à partir de la liste
                  ...messagesList.map((msg) => buildMessageCard(
                        sender: msg.sender,
                        role: msg.role,
                        preview: msg.preview,
                        time: msg.time,
                        unread: msg.unread,
                      )),

                  const SizedBox(height: 20),

                  // ---- NEW MESSAGE BUTTON ----
                  SizedBox(
                    width: 260,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 126, 214),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NouveauMessageScreen()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Nouveau message",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  // ------------------------------------------------
  // MESSAGE CARD (INCHANGÉ, juste réutilisé)
  // ------------------------------------------------
  Widget buildMessageCard({
    required String sender,
    required String role,
    required String preview,
    required String time,
    required int unread,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xfff6f4ff),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON AVATAR
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.grey, size: 28),
          ),
          const SizedBox(width: 12),

          // TEXT ZONE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  preview,
                  maxLines: 2, // Ajouté pour éviter que le texte dépasse trop
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          // TIME + UNREAD BADGE
          Column(
            children: [
              if (time.isNotEmpty)
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              if (unread > 0)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 239, 76, 6),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unread.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}