import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/services/local_storage_service.dart';
import 'package:pgl_p2_myportfolio/core/widgets/drawer_menu.dart';
import 'package:pgl_p2_myportfolio/features/dishes/data/dishes.dart';

/// Settings screen. The values are saved with LocalStorageService
/// (shared_preferences), so they are still there after closing the app.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // The screen only talks to the service, never to shared_preferences
  final LocalStorageService _storage = LocalStorageService.getInstance();

  final _dishController = TextEditingController();

  // Value selected in the dropdown
  String _favoriteIsland = islands.first;

  // Text saved last time (shown under the input)
  String? _savedDish;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _dishController.dispose();
    super.dispose();
  }

  /// Reads what was saved in previous executions of the app.
  void _loadSettings() {
    final String? island = _storage.getFavoriteIsland();
    // Only use the saved island if it is still one of the options
    if (island != null && islands.contains(island)) {
      _favoriteIsland = island;
    }
    _savedDish = _storage.getFavoriteDish();
    _dishController.text = _savedDish ?? '';
  }

  /// Dropdown: the island is saved as soon as the user picks it.
  Future<void> _onIslandChanged(String? island) async {
    if (island == null) return;
    setState(() => _favoriteIsland = island);
    await _storage.saveFavoriteIsland(island);
    _showMessage(AppStrings.islandSaved, AppColors.success);
  }

  /// Button: saves the text written in the input.
  Future<void> _saveDish() async {
    final String text = _dishController.text.trim();
    if (text.isEmpty) {
      _showMessage(AppStrings.requiredField, AppColors.warning);
      return;
    }
    final bool ok = await _storage.saveFavoriteDish(text);
    if (!ok) {
      _showMessage(AppStrings.saveError, AppColors.error);
      return;
    }
    setState(() => _savedDish = text);
    _showMessage(AppStrings.dishSaved, AppColors.success);
  }

  /// Deletes the saved settings and goes back to the default values.
  Future<void> _resetSettings() async {
    await _storage.clearSettings();
    setState(() {
      _favoriteIsland = islands.first;
      _savedDish = null;
      _dishController.clear();
    });
    _showMessage(AppStrings.settingsReset, AppColors.info);
  }

  void _showMessage(String text, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      drawer: const DrawerMenu(),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        children: [
          // ---------- Dropdown ----------
          const _SectionTitle(
            icon: Icons.landscape,
            text: AppStrings.favoriteIslandTitle,
          ),
          const SizedBox(height: AppSizes.spacing),
          DropdownButtonFormField<String>(
            // The key forces a rebuild when the value changes from code
            // (for example after "Borrar ajustes"), because initialValue
            // is only read the first time.
            key: ValueKey(_favoriteIsland),
            initialValue: _favoriteIsland,
            decoration: const InputDecoration(
              labelText: AppStrings.dishIsland,
              border: OutlineInputBorder(),
            ),
            items: [
              for (final island in islands)
                DropdownMenuItem(value: island, child: Text(island)),
            ],
            onChanged: _onIslandChanged,
          ),

          const SizedBox(height: AppSizes.spacingLarge),

          // ---------- Text input + button ----------
          const _SectionTitle(
            icon: Icons.restaurant,
            text: AppStrings.favoriteDishTitle,
          ),
          const SizedBox(height: AppSizes.spacing),
          TextField(
            controller: _dishController,
            maxLength: AppSizes.maxNameLength,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: AppStrings.favoriteDishLabel,
              hintText: AppStrings.favoriteDishHint,
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _saveDish(),
          ),
          const SizedBox(height: AppSizes.padding),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: _saveDish,
            icon: const Icon(Icons.save),
            label: const Text(AppStrings.save),
          ),
          const SizedBox(height: AppSizes.spacing),

          // What is saved in memory right now
          Card(
            child: ListTile(
              leading: const Icon(Icons.bookmark, color: AppColors.secondary),
              title: const Text(AppStrings.savedValueTitle),
              subtitle: Text(
                '${AppStrings.dishIsland}: $_favoriteIsland\n'
                '${AppStrings.favoriteDishLabel}: '
                '${_savedDish ?? AppStrings.nothingSaved}',
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spacingLarge),
          TextButton.icon(
            onPressed: _resetSettings,
            icon: const Icon(Icons.restart_alt, color: AppColors.error),
            label: const Text(
              AppStrings.resetSettings,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Title of each section of the settings.
class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SectionTitle({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: AppSizes.titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
