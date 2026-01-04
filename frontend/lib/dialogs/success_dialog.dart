import 'package:flutter/material.dart';
import '../core/constants/app_sizes.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onDismiss;
  final Duration autoCloseDuration;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    this.onDismiss,
    this.autoCloseDuration = const Duration(seconds: 3),
  });

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onDismiss,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SuccessDialog(
        title: title,
        message: message,
        onDismiss: onDismiss,
        autoCloseDuration: autoCloseDuration,
      ),
    );

    // Auto close after duration
    Future.delayed(autoCloseDuration, () {
      if (context.mounted) {
        Navigator.pop(context);
        onDismiss?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
      ),
      title: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 28),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.grey),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
            onDismiss?.call();
          },
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}
