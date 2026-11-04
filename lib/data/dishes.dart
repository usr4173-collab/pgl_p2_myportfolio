import '../models/dish.dart';
import '../models/dish_category.dart';

/// Options for the dropdowns of the form.
const List<String> islands = [
  'Tenerife',
  'Gran Canaria',
  'Lanzarote',
  'Fuerteventura',
  'La Palma',
  'La Gomera',
  'El Hierro',
  'La Graciosa',
];

/// Dishes shown the first time the CRUD screen is opened.
const List<Dish> initialDishes = [
  Dish(
    name: 'Papas arrugadas',
    island: 'Tenerife',
    category: DishCategory.dish,
    description: 'Papas cocidas con mucha sal, servidas con mojo.',
  ),
  Dish(
    name: 'Mojo picón',
    island: 'Gran Canaria',
    category: DishCategory.sauce,
    description: 'Salsa de pimienta, ajo, aceite y vinagre.',
  ),
  Dish(
    name: 'Queso majorero',
    island: 'Fuerteventura',
    category: DishCategory.product,
    description: 'Queso de cabra con Denominación de Origen.',
  ),
  Dish(
    name: 'Gofio escaldado',
    island: 'La Gomera',
    category: DishCategory.dish,
    description: 'Gofio mezclado con caldo de pescado.',
  ),
  Dish(
    name: 'Bienmesabe',
    island: 'La Palma',
    category: DishCategory.dessert,
    description: 'Dulce de almendra, huevo y azúcar.',
  ),
];
