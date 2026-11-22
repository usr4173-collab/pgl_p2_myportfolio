import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pgl_p2_myportfolio/core/constants/api_constants.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';

/// Error with the message that we show to the user.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Talks with the users API. The screens never use http directly:
/// they call this service, so the API details are in one place.
class AuthService {
  /// POST /users/register with { fullName, email, pwd }.
  /// Returns the success message of the API (201 Created).
  /// Throws [AuthException] with the API message if something goes wrong
  /// (400 missing fields, 409 email already registered, 500...).
  static Future<String> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);

    final http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            // The API expects the password in the field "pwd"
            body: jsonEncode({
              'fullName': fullName,
              'email': email,
              'pwd': password,
            }),
          )
          .timeout(ApiConstants.timeout);
    } catch (_) {
      // No internet, server down or timeout
      throw const AuthException(AppStrings.connectionError);
    }

    final String message = _readMessage(response);
    if (response.statusCode == 201) {
      return message;
    }
    throw AuthException(message);
  }

  /// Every answer of the API has the shape { "message": "..." }.
  static String _readMessage(http.Response response) {
    try {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return json['message'] as String;
    } catch (_) {
      return AppStrings.connectionError;
    }
  }
}
