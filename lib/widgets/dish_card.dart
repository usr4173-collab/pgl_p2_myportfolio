import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../models/dish.dart';

/// Card that shows one dish: category image, name, category · island and description.
/// The delete button does not delete anything by itself: it calls [onDelete]
/// and the screen (which owns the list) decides what to do.
class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onDelete;

  const DishCard({super.key, required this.dish, required this.onDelete});

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
        // Delete button on the right of each dish
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: AppColors.error),
          tooltip: AppStrings.delete,
          onPressed: onDelete,
        ),
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
