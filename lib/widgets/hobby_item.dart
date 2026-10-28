import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../models/hobby.dart';

/// Card for a single hobby: colored icon + name.
class HobbyItem extends StatelessWidget {
  final Hobby hobby;

  const HobbyItem({super.key, required this.hobby});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(hobby.icon, size: AppSizes.hobbyIcon, color: hobby.color),
            const SizedBox(height: AppSizes.padding),
            Text(
              hobby.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.text),
            ),
          ],
        ),
      ),
    );
  }
}
