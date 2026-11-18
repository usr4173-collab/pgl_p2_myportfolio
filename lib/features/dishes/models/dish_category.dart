import 'package:flutter/material.dart';

/// Possible categories of a dish.
/// Each category has the text shown to the user and its icon.
enum DishCategory {
  dish('Plato', Icons.restaurant, 'assets/images/categories/plato.jpg'),
  product('Producto', Icons.shopping_basket, 'assets/images/categories/producto.jpg'),
  dessert('Postre', Icons.cake, 'assets/images/categories/postre.jpg'),
  sauce('Salsa', Icons.local_dining, 'assets/images/categories/salsa.jpg');

  const DishCategory(this.label, this.icon, this.imagePath);

  final String label;
  final IconData icon;
  final String imagePath;
}
