class SettingsModel {
  final String userName;
  final String userPhone;
  final bool pushNotifications;
  final bool gradeAlerts;
  final bool messageAlerts;
  final bool absenceAlerts;
  final bool isDarkMode;
  final String currentLanguage;
  final String passwordLastChanged;

  SettingsModel({
    required this.userName,
    required this.userPhone,
    required this.pushNotifications,
    required this.gradeAlerts,
    required this.messageAlerts,
    required this.absenceAlerts,
    required this.isDarkMode,
    required this.currentLanguage,
    required this.passwordLastChanged,
  });
}
