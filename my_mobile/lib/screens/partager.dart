import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pour la requête
import 'package:file_picker/file_picker.dart'; // Pour choisir le PDF
import 'package:flutter/foundation.dart'; // Pour kIsWeb

// --- CONFIGURATION ---
// ⚠️ TRES IMPORTANT : Mets l'adresse IP de ton PC (ipconfig / ifconfig)
const String serverIP = "192.168.100.17"; 
const String port = "5000";

class UploadDocumentPage extends StatefulWidget {
  const UploadDocumentPage({super.key});

  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  // Contrôleurs pour les champs texte
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  // Listes déroulantes
  String? selectedType;
  String? selectedSubject;

  // Gestion du fichier
  FilePickerResult? result;
  String? fileName;
  bool isSubmitting = false; // Pour afficher le chargement

  // Données statiques (tu pourrais aussi les charger depuis le serveur plus tard)
  final List<String> types = ["Cours", "TD", "TP", "Examen", "Rapport"];
  final List<String> subjects = [
    "Programmation C",
    "Analyse",
    "Algorithmique",
    "Réseaux",
    "Systèmes",
    "Maths",
    "Anglais"
  ];

  // --- LOGIQUE ---

  // Génère l'URL selon si on est sur Web ou Mobile
  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:$port';
    return 'http://$serverIP:$port';
  }

  // 1. Choisir un fichier PDF
  Future<void> pickFile() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // On force le PDF uniquement
        withData: true, // Nécessaire pour le Web
      );

      if (result != null) {
        setState(() {
          fileName = result!.files.single.name;
        });
      }
    } catch (e) {
      print("Erreur choix fichier: $e");
    }
  }

  // 2. Envoyer au serveur
  Future<void> submitDocument() async {
    // A. Validation des champs
    if (titleCtrl.text.isEmpty || selectedSubject == null || selectedType == null) {
      _showSnackBar("Merci de remplir le titre, la matière et le type.", Colors.orange);
      return;
    }

    if (result == null) {
      _showSnackBar("N'oublie pas de joindre le fichier PDF !", Colors.redAccent);
      return;
    }

    setState(() => isSubmitting = true);

    try {
      var uri = Uri.parse('${getBaseUrl()}/api/shared-docs');
      var request = http.MultipartRequest('POST', uri);

      // B. Ajout des champs texte
      request.fields['title'] = titleCtrl.text;
      request.fields['subject'] = selectedSubject!;
      request.fields['tag'] = selectedType!;
      request.fields['description'] = descriptionCtrl.text;
      request.fields['teacher'] = "Étudiant"; // Valeur par défaut

      // C. Ajout du fichier (Logique différente Web vs Mobile)
      var file = result!.files.single;
      
      if (kIsWeb) {
        // Sur Web, on utilise les octets (bytes)
        if (file.bytes != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'pdfFile', // ⚠️ Doit correspondre exactement à 'upload.single' dans le backend
              file.bytes!,
              filename: file.name,
            ),
          );
        }
      } else {
        // Sur Mobile, on utilise le chemin (path)
        if (file.path != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'pdfFile', 
              file.path!,
            ),
          );
        }
      }

      // D. Envoi de la requête
      var response = await request.send();

      // E. Traitement de la réponse
      if (response.statusCode == 201) {
        if (!mounted) return;
        _showSnackBar("Document partagé avec succès ! 🚀", Colors.green);
        
        // 🔙 Retour à la page précédente avec 'true' pour dire de recharger la liste
        Navigator.pop(context, true); 
      } else {
        throw Exception("Erreur serveur (Code: ${response.statusCode})");
      }

    } catch (e) {
      print(e);
      if (mounted) {
        _showSnackBar("Échec de l'envoi. Vérifie ta connexion.", Colors.red);
      }
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  // Petit helper pour afficher les messages
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Gris très clair
      appBar: AppBar(
        title: const Text("Partager un document", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 64, 179, 255),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // --- CARTE FORMULAIRE ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                   // Champ Titre
                   TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: "Titre du document",
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Champ Matière
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Matière",
                      prefixIcon: Icon(Icons.book),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    initialValue: selectedSubject,
                    items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => selectedSubject = v),
                  ),
                  const SizedBox(height: 16),

                  // Champ Type
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Type de document",
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    initialValue: selectedType,
                    items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (v) => setState(() => selectedType = v),
                  ),
                  const SizedBox(height: 16),

                  // Champ Description
                  TextField(
                    controller: descriptionCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Description (facultatif)",
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- ZONE UPLOAD FICHIER ---
            GestureDetector(
              onTap: pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: fileName == null ? Colors.white : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: fileName == null ? Colors.grey.shade300 : Colors.green, 
                    width: 2,
                    style: BorderStyle.solid // On pourrait mettre dashed ici avec un package externe
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      fileName == null ? Icons.cloud_upload_outlined : Icons.check_circle,
                      size: 50,
                      color: fileName == null ? Colors.blueGrey : Colors.green,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fileName ?? "Cliquez pour choisir un PDF",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fileName == null ? Colors.grey.shade700 : Colors.green.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (fileName == null)
                      Text("(Format .pdf accepté uniquement)", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- BOUTON VALIDER ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : submitDocument,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 8, 151, 234),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 5,
                ),
                child: isSubmitting
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                          SizedBox(width: 15),
                          Text("Envoi en cours...", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      )
                    : const Text("PUBLIER LE DOCUMENT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}