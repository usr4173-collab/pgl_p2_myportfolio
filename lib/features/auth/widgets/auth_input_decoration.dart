import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';

/// Same look for every input of the auth screens (register and login):
/// label + orange icon + rounded border.
InputDecoration authInputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: AppColors.primary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    ),
  );
}
