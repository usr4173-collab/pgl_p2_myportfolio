import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

/// Strip with the profile photo and the introduction text.
class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.secondary.withValues(alpha: 0.2),
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      child: const Row(
        children: [
          _ProfilePhoto(),
          SizedBox(width: AppSizes.spacing),
          Expanded(
            child: Text(
              AppStrings.introduction,
              style: TextStyle(fontSize: AppSizes.textSize, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}

/// Round photo. If the image cannot be loaded, it shows an icon instead.
class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        AppStrings.profilePhoto,
        width: AppSizes.photo,
        height: AppSizes.photo,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: AppSizes.photo,
          height: AppSizes.photo,
          color: AppColors.primary,
          child: const Icon(
            Icons.person,
            size: AppSizes.photo / 2,
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }
}
