import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../models/dish.dart';

/// Card that shows one dish: category image, name, category · island and description.
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        // The image depends on the category of the dish
        leading: _CategoryImage(dish: dish),
        title: Text(dish.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${dish.category.label} · ${dish.island}\n${dish.description}'),
        isThreeLine: true,
      ),
    );
  }
}

/// Square image with rounded corners taken from the category.
/// If the image cannot be loaded, the category icon is shown instead.
class _CategoryImage extends StatelessWidget {
  final Dish dish;

  const _CategoryImage({required this.dish});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      child: Image.asset(
        dish.category.imagePath,
        width: AppSizes.categoryImage,
        height: AppSizes.categoryImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: AppSizes.categoryImage,
          height: AppSizes.categoryImage,
          color: AppColors.secondary,
          child: Icon(dish.category.icon, color: AppColors.textOnPrimary),
        ),
      ),
    );
  }
}
