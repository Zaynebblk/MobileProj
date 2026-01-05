import 'package:flutter/material.dart';
import '../models/document_model.dart';

class DocumentViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<DocumentModel> documents = [];

  bool get isLoading => _isLoading;

  // Stats
  int get totalDocs => documents.length;
  int get pendingDocs => documents.where((d) => d.status == "En attente").length;
  int get signedDocs => documents.where((d) => d.status == "Signé").length;

  Future<void> fetchDocuments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    // Données fictives
    documents = [
      DocumentModel(id: "1", title: "Convention de Stage PFE", studentName: "Amine Tounsi", type: "Stage", date: "06 Jan 2024", status: "En attente"),
      DocumentModel(id: "2", title: "Attestation de présence", studentName: "Sarra Ben Amor", type: "Scolarité", date: "05 Jan 2024", status: "Signé"),
      DocumentModel(id: "3", title: "Relevé de notes (Anglais)", studentName: "Karim Zribi", type: "Scolarité", date: "04 Jan 2024", status: "En attente"),
      DocumentModel(id: "4", title: "Lettre de recommandation", studentName: "Nour El Houda", type: "Divers", date: "02 Jan 2024", status: "Signé"),
      DocumentModel(id: "5", title: "Demande de dérogation", studentName: "Ahmed Salah", type: "Admin", date: "01 Jan 2024", status: "Rejeté"),
    ];

    _isLoading = false;
    notifyListeners();
  }
}