import 'package:shared_preferences/shared_preferences.dart';

/// Service that saves and reads simple values in the device storage
/// (key-value pairs) using shared_preferences.
///
/// The UI never uses SharedPreferences directly: it only calls this service.
/// This way the screens are decoupled from the storage logic.
///
/// It follows the Singleton pattern: there is only one instance in the app.
class LocalStorageService {
  LocalStorageService._internal();
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService.getInstance() => _instance;

  // Keys used to save each value (constants to avoid typos)
  static const String _favoriteIslandKey = 'favorite_island';
  static const String _favoriteDishKey = 'favorite_dish';

  // Instance of shared_preferences. It is created once in initialize().
  late SharedPreferences _prefs;

  /// Must be called once in main() before runApp().
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---------- Favorite island (dropdown) ----------

  /// Returns the saved island, or null if nothing was saved yet.
  String? getFavoriteIsland() => _prefs.getString(_favoriteIslandKey);

  /// Saves the island. Returns true if it was saved correctly.
  Future<bool> saveFavoriteIsland(String island) =>
      _prefs.setString(_favoriteIslandKey, island);

  // ---------- Favorite dish (text input) ----------

  /// Returns the saved text, or null if nothing was saved yet.
  String? getFavoriteDish() => _prefs.getString(_favoriteDishKey);

  /// Saves the text. Returns true if it was saved correctly.
  Future<bool> saveFavoriteDish(String dish) =>
      _prefs.setString(_favoriteDishKey, dish);

  /// Deletes all the saved settings.
  Future<void> clearSettings() async {
    await _prefs.remove(_favoriteIslandKey);
    await _prefs.remove(_favoriteDishKey);
  }
}
