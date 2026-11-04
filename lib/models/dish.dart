import 'dish_category.dart';

/// Data model: a typical Canarian dish or product.
class Dish {
  final String name;
  final String description; // short text (max. AppSizes.maxDescriptionLength)
  final DishCategory category;
  final String island;

  const Dish({
    required this.name,
    required this.description,
    required this.category,
    required this.island,
  });
}
