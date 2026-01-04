import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryRed = Color(0xffff5f6e);
  static const Color primaryBlue = Color(0xFF4062C0);
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color primaryOrange = Color(0xFFFF9800);

  // Background Colors
  static const Color bgLight = Color(0xfffdf7ef);
  static const Color bgGrey = Color(0xffF5F8F7);
  static const Color bgDark = Color.fromARGB(255, 4, 39, 61);

  // Gradient Colors
  static const LinearGradient gradientPink = LinearGradient(
    colors: [Color(0xfff23859), Color(0xfffb729e)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Status Colors
  static const Color statusSuccess = Colors.green;
  static const Color statusWarning = Colors.deepOrange;
  static const Color statusError = Colors.red;
  static const Color statusPending = Colors.orange;

  // Text Colors
  static const Color textDark = Colors.black87;
  static const Color textGrey = Colors.grey;
  static const Color textWhite = Colors.white;
  static const Color textHint = Colors.white54;

  // Shades
  static const Color shadow = Colors.black12;
  static const Color border = Colors.black26;
}
