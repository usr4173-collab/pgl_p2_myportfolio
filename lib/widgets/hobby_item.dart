import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../models/hobby.dart';

/// Card for a single hobby: icon in a yellow circle + name.
class HobbyItem extends StatelessWidget {
  final Hobby hobby;

  const HobbyItem({super.key, required this.hobby});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary,
          child: Icon(hobby.icon, color: AppColors.textOnPrimary, size: AppSizes.hobbyIcon),
        ),
        title: Text(
          hobby.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.text),
        ),
      ),
    );
  }
}
