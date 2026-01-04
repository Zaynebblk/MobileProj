import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTextStyles {
  // Titles
  static const TextStyle titleLarge = TextStyle(
    fontSize: AppSizes.fontTitle,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: AppSizes.fontXl,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: AppSizes.fontLg,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: AppSizes.fontBase,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: AppSizes.fontBody,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: AppSizes.fontBase,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: AppSizes.fontBody,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
  );

  // Special
  static const TextStyle white = TextStyle(
    fontSize: AppSizes.fontBase,
    color: AppColors.textWhite,
  );

  static const TextStyle whiteBold = TextStyle(
    fontSize: AppSizes.fontBase,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  static const TextStyle hint = TextStyle(
    fontSize: AppSizes.fontBody,
    color: AppColors.textHint,
  );
}
