import 'package:flutter/material.dart';

/// Possible categories of a dish.
/// Each category has the text shown to the user and its icon.
enum DishCategory {
  dish('Plato', Icons.restaurant),
  product('Producto', Icons.shopping_basket),
  dessert('Postre', Icons.cake),
  sauce('Salsa', Icons.local_dining);

  const DishCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
