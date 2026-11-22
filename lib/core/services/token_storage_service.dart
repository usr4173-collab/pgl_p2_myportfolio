import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Saves the session token (JWT) in a SECURE way in the device.
///
/// It uses flutter_secure_storage instead of shared_preferences because:
/// - shared_preferences saves plain text (anyone with access to the files
///   of the app could read the token and use the session).
/// - flutter_secure_storage encrypts the data with the system tools:
///   Android Keystore on Android and Keychain on iOS.
///
/// Singleton, like LocalStorageService: only one instance in the app.
class TokenStorageService {
  TokenStorageService._internal();
  static final TokenStorageService _instance = TokenStorageService._internal();
  factory TokenStorageService.getInstance() => _instance;

  // Key used to save the token (constant to avoid typos)
  static const String _tokenKey = 'auth_token';

  // encryptedSharedPreferences: on Android the values are encrypted with
  // AES and the key is kept in the Android Keystore
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// Saves (or replaces) the token after a successful login.
  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  /// Returns the saved token, or null if there is no session.
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  /// Deletes the token (for example when the user logs out).
  Future<void> deleteToken() => _storage.delete(key: _tokenKey);
}
