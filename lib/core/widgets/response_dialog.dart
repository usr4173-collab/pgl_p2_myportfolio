import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';

/// Shows the answer of the API to the user in an alert (AlertDialog).
/// [success] changes the icon, the color and the title.
/// It is a Future: the code that calls it can `await` until the user
/// presses "Aceptar" (useful later to navigate after closing it).
Future<void> showResponseDialog(
  BuildContext context, {
  required bool success,
  required String message,
}) {
  final Color color = success ? AppColors.success : AppColors.error;

  return showDialog<void>(
    context: context,
    // The user must press the button: tapping outside does not close it
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: color,
        size: 48,
      ),
      title: Text(
        success ? AppStrings.successTitle : AppStrings.errorTitle,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      // The text comes from the API ("message" field) or from the app
      content: Text(message, textAlign: TextAlign.center),
      actions: [
        TextButton(
          // dialogContext is the context of the dialog itself
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text(AppStrings.accept),
        ),
      ],
    ),
  );
}
