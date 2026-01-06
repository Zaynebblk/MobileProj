import 'package:flutter/material.dart';

// Modèle (Identique à celui de la liste)
class TicketData {
  final String id;
  final String studentName;
  final String studentClass;
  final String type; 
  final String subject;
  final String date;
  final String message;
  final bool hasAttachment;

  TicketData({
    required this.id,
    required this.studentName,
    required this.studentClass,
    required this.type,
    required this.subject,
    required this.date,
    required this.message,
    this.hasAttachment = false,
  });
}

class TicketDetailView extends StatefulWidget {
  final TicketData ticket;

  const TicketDetailView({super.key, required this.ticket});

  @override
  State<TicketDetailView> createState() => _TicketDetailViewState();
}

class _TicketDetailViewState extends State<TicketDetailView> {
  final TextEditingController _responseController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    // --- PALETTE HARMONISÉE (STYLE PUBLISH/ADMIN) ---
    final pinkHeader = const Color(0xFFE91E63);
    final creamBg = const Color(0xFFFFF8E1);
    final orangeBtn = const Color(0xFFE65100); // Orange Vif pour l'action principale
    final orangeAccent = Colors.orange;
    final tealAccent = Colors.teal;

    // Détermine la couleur d'accent (Orange pour urgent/rectif, Teal pour le reste)
    Color dynamicColor = widget.ticket.type.contains("Rectification") ? orangeAccent : tealAccent;

    return Scaffold(
      backgroundColor: creamBg,
      // AppBar simplifiée pour fusionner avec le header personnalisé
      appBar: AppBar(
        backgroundColor: pinkHeader,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Traitement Ticket", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER PROFIL (ROSE) ---
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              decoration: BoxDecoration(
                color: pinkHeader,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: pinkHeader.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    // La lettre prend la couleur dynamique (Orange ou Teal)
                    child: Text(widget.ticket.studentName[0], style: TextStyle(color: dynamicColor, fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.ticket.studentName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("${widget.ticket.studentClass} • ID: ${widget.ticket.id}", style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- INFO TICKET (Badge dynamique) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: dynamicColor.withOpacity(0.15), // Fond léger basé sur la couleur
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          widget.ticket.type.toUpperCase(), 
                          style: TextStyle(color: dynamicColor, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5)
                        ),
                      ),
                      Text(widget.ticket.date, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- CONTENU DE LA DEMANDE ---
                  Text("Détails de la demande", style: TextStyle(color: Colors.brown[700], fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.ticket.subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(widget.ticket.message, style: const TextStyle(color: Colors.black87, height: 1.5)),
                        
                        // Simulation Pièce Jointe
                        if (widget.ticket.hasAttachment) ...[
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {}, 
                            child: Row(
                              children: [
                                Icon(Icons.attach_file, color: dynamicColor),
                                const SizedBox(width: 10),
                                Text("Preuve_Note_DS.jpg", style: TextStyle(color: dynamicColor, decoration: TextDecoration.underline)),
                                const Spacer(),
                                Icon(Icons.visibility, color: Colors.grey[400], size: 18),
                              ],
                            ),
                          )
                        ]
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- ZONE DE RÉPONSE ---
                  Text("Réponse de l'administration", style: TextStyle(color: Colors.brown[700], fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  
                  TextField(
                    controller: _responseController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Écrivez votre réponse ou justification ici...",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      // Focus en Orange pour rappeler le bouton d'action
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: orangeBtn, width: 2)),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- BOUTONS D'ACTION ---
                  Row(
                    children: [
                      // Bouton Refuser
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _handleAction(context, "Refusé", Colors.red);
                          },
                          icon: const Icon(Icons.close),
                          label: const Text("REFUSER"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      
                      // Bouton Valider (Style "ORANGE PUBLISH")
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                             _handleAction(context, "Traité", tealAccent);
                          },
                          icon: const Icon(Icons.check),
                          label: const Text("VALIDER"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orangeBtn, // L'Orange signature
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            shadowColor: orangeBtn.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, String newStatus, Color color) {
    if (_responseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Veuillez ajouter un commentaire avant de valider.")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text("Ticket marqué comme $newStatus"),
        behavior: SnackBarBehavior.floating,
      )
    );
    
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }
}