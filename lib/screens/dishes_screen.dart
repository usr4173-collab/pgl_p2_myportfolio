import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../data/dishes.dart';
import '../models/dish.dart';
import '../widgets/dish_card.dart';
import '../widgets/dish_form_dialog.dart';
import '../widgets/drawer_menu.dart';

/// CRUD screen: here the user will see, add, edit and delete dishes.
/// It is a StatefulWidget because the list of dishes will change
/// (when adding or deleting) and the screen must be redrawn.
class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  // The list lives in the state. List.of makes a copy we can modify
  // (initialDishes is const and cannot be changed).
  final List<Dish> _dishes = List.of(initialDishes);

  /// CREATE: opens the modal and, if it returns a dish, adds it to the list.
  Future<void> _addDish() async {
    // showDialog shows the modal and waits (await) until it is closed
    final Dish? newDish = await showDialog<Dish>(
      context: context,
      builder: (context) => const DishFormDialog(),
    );

    // null = the user tapped "Cancelar"
    if (newDish == null) return;

    // setState redraws the screen with the new dish in the list
    setState(() => _dishes.add(newDish));

    // The screen could have been closed while the dialog was open
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.dishAdded),
        backgroundColor: AppColors.success,
      ),
    );
  }

  /// DELETE: asks for confirmation and, if the user accepts, removes the dish.
  Future<void> _deleteDish(Dish dish) async {
    // The dialog returns true (Borrar) or false/null (Cancelar or tap outside)
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: AppColors.warning),
        title: const Text(AppStrings.deleteDishTitle),
        content: Text('${AppStrings.deleteDishQuestion} "${dish.name}".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              AppStrings.delete,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // setState redraws the list without the deleted dish
    setState(() => _dishes.remove(dish));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.dishDeleted),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.dishesTitle)),
      drawer: const DrawerMenu(),
      // If there are no dishes we show a message; if there are, the list.
      body: _dishes.isEmpty ? const _EmptyMessage() : _buildList(),
      // "+" button at the bottom right that opens the modal
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        tooltip: AppStrings.addDish,
        onPressed: _addDish,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Dynamic list: ListView.builder only builds the cards that are on screen
  /// and creates as many as there are elements in _dishes.
  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: _dishes.length,
      itemBuilder: (context, index) {
        final dish = _dishes[index];
        return DishCard(
          dish: dish,
          onDelete: () => _deleteDish(dish),
        );
      },
    );
  }
}

/// Message shown when the list is empty.
class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info, color: AppColors.info, size: 48),
          SizedBox(height: 8),
          Text(AppStrings.noDishes),
        ],
      ),
    );
  }
}
