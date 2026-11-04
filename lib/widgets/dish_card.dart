import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/dish.dart';

/// Card that shows one dish: icon by category, name, category · island and description.
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary,
          child: Icon(dish.category.icon, color: AppColors.textOnPrimary),
        ),
        title: Text(dish.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${dish.category.label} · ${dish.island}\n${dish.description}'),
        isThreeLine: true,
      ),
    );
  }
}
