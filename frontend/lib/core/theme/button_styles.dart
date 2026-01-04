import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppButtonStyles {
  // Elevated Button Styles
  static final elevatedPrimaryStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryBlue,
    padding: const EdgeInsets.symmetric(vertical: AppSizes.lg),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
    ),
  );

  static final elevatedOrangeStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryOrange,
    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
    ),
  );

  static final elevatedGreenStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.statusSuccess,
    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
    ),
  );

  // Outlined Button Styles
  static final outlinedOrangeStyle = OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.primaryOrange),
    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
    ),
  );

  static final outlinedPrimaryStyle = OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.primaryBlue),
    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
    ),
  );

  // Text Button Styles
  static final textPrimaryStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryBlue,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.lg,
      vertical: AppSizes.md,
    ),
  );

  static final textOrangeStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryOrange,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.lg,
      vertical: AppSizes.md,
    ),
  );
}
