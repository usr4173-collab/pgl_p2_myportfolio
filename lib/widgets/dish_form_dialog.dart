import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../data/dishes.dart';
import '../models/dish.dart';
import '../models/dish_category.dart';

/// Modal (Dialog) with a form to create a dish.
/// When the user taps "Guardar", the dialog closes and returns the new Dish.
/// If the user taps "Cancelar", it returns nothing (null).
class DishFormDialog extends StatefulWidget {
  const DishFormDialog({super.key});

  @override
  State<DishFormDialog> createState() => _DishFormDialogState();
}

class _DishFormDialogState extends State<DishFormDialog> {
  // Key to validate all the fields of the form at once
  final _formKey = GlobalKey<FormState>();

  // Controllers: they store what the user types
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Values chosen in the dropdowns
  String _island = islands.first;
  DishCategory _category = DishCategory.dish;

  @override
  void dispose() {
    // Controllers must be freed when the dialog closes
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Checks the form and, if it is correct, closes the dialog returning the dish
  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final newDish = Dish(
      name: _nameController.text.trim(),
      island: _island,
      category: _category,
      description: _descriptionController.text.trim(),
    );
    Navigator.pop(context, newDish);
  }

  // Validator for the required text fields
  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.requiredField;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.addDish,
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  maxLength: AppSizes.maxNameLength,
                  decoration: const InputDecoration(
                    labelText: AppStrings.dishName,
                    prefixIcon: Icon(Icons.restaurant),
                  ),
                  validator: _required,
                ),
                DropdownButtonFormField<String>(
                  initialValue: _island,
                  decoration: const InputDecoration(
                    labelText: AppStrings.dishIsland,
                    prefixIcon: Icon(Icons.landscape),
                  ),
                  items: [
                    for (final island in islands)
                      DropdownMenuItem(value: island, child: Text(island)),
                  ],
                  onChanged: (value) => setState(() => _island = value!),
                ),
                // Category selector: one option for each value of the enum
                DropdownButtonFormField<DishCategory>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: AppStrings.dishCategory,
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: [
                    for (final category in DishCategory.values)
                      DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Icon(category.icon, size: 20, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(category.label),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => _category = value!),
                ),
                TextFormField(
                  controller: _descriptionController,
                  // Short description: max. 60 characters and up to 2 lines.
                  // maxLength also shows a counter (e.g. 12/60) under the field.
                  maxLength: AppSizes.maxDescriptionLength,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: AppStrings.dishDescription,
                    hintText: AppStrings.shortDescriptionHint,
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: _required,
                ),
                const SizedBox(height: 24),
                // Buttons aligned to the right
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // returns null
                      child: const Text(AppStrings.cancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textOnPrimary,
                      ),
                      onPressed: _save,
                      child: const Text(AppStrings.save),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
