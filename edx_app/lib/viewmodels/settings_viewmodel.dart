import '../models/settings_model.dart';

class SettingsViewModel {
  SettingsModel getSettings() {
    return SettingsModel(
      userName: "Ahmed Ben Ameur",
      userPhone: "55 181 294",
      pushNotifications: true,
      gradeAlerts: true,
      messageAlerts: true,
      absenceAlerts: false,
      isDarkMode: false,
      currentLanguage: "Français",
      passwordLastChanged: "il y a 3 mois",
    );
  }

  void logout() {
    // Logic for logging out would go here
    print("User logged out");
  }
}
