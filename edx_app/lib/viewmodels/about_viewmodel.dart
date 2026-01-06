import '../models/about_model.dart';

class AboutViewModel {
  AboutModel getAboutData() {
    return AboutModel(
      presentation: "L'École Supérieure des Communications de Tunis est la grande école d'ingénieurs des télécommunications en Tunisie.",
      studentsCount: "1200+",
      teachersCount: "90+",
      partnersCount: "30+",
      labsCount: "15",
      departments: [
        "Réseaux et Services",
        "Systèmes de Communications",
        "Technologies du Numérique",
        "Langues et Management",
      ],
      address: "Cité Technologique des Communications, Raoued",
      phone: "+216 70 011 000",
      website: "www.supcom.tn",
    );
  }
}
