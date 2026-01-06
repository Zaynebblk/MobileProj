import 'package:flutter/material.dart';
import '../models/info_model.dart';

class InfoViewModel {
  GeneralInfoModel getInfoData() {
    return GeneralInfoModel(
      announcement: "Annonce importante: Les inscriptions pour les examens de rattrapage sont ouvertes jusqu'au 20 novembre 2024.",
      faqs: [
        {"q": "Comment consulter mes notes ?", "a": "Via le portail étudiant section Résultats."},
        {"q": "Comment justifier une absence ?", "a": "Envoyez un justificatif à la scolarité sous 48h."},
      ],
      events: [
        CalendarEvent("Semestre 1", "16 sept 2024 - 15 jan 2025", "En cours", Colors.blue),
        CalendarEvent("Examens S1", "20 jan - 05 fév 2025", "À venir", Colors.grey),
        CalendarEvent("Vacances d'hiver", "06 fév - 16 fév 2025", "À venir", Colors.grey),
      ],
      services: [
        {"name": "Scolarité", "bureau": "Bureau A.1.01", "email": "scolarite@supcom.tn"},
        {"name": "Bibliothèque", "bureau": "Bâtiment c", "email": "biblio@supcom.tn"},
      ],
    );
  }
}