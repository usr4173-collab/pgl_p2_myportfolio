import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pgl_p2_myportfolio/core/constants/api_constants.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/features/auth/models/user.dart';

/// Error with the message that we show to the user.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Data returned by a successful login (200 OK).
class LoginResponse {
  final String message;
  final String token; // JWT for the protected routes
  final User user;

  const LoginResponse({
    required this.message,
    required this.token,
    required this.user,
  });
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
    final http.Response response = await _post(ApiConstants.register, {
      'fullName': fullName,
      'email': email,
      'pwd': password, // the API expects the password in "pwd"
    });

    final Map<String, dynamic> json = _readJson(response);
    if (response.statusCode == 201) {
      return json['message'] as String;
    }
    throw AuthException(json['message'] as String);
  }

  /// POST /users/login with { email, pwd }.
  /// Returns message + JWT token + user (200 OK).
  /// Throws [AuthException] with the API message if something goes wrong
  /// (400 missing fields, 409 wrong credentials, 500...).
  static Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final http.Response response = await _post(ApiConstants.login, {
      'email': email,
      'pwd': password,
    });

    final Map<String, dynamic> json = _readJson(response);
    if (response.statusCode == 200) {
      try {
        return LoginResponse(
          message: json['message'] as String,
          token: json['token'] as String,
          user: User.fromJson(json['user'] as Map<String, dynamic>),
        );
      } catch (_) {
        // 200 but without token/user: still show an alert, never get stuck
        throw const AuthException(AppStrings.connectionError);
      }
    }
    throw AuthException(json['message'] as String);
  }

  /// GET /users/check-token with the header "Authorization: Bearer <token>".
  /// Returns true if the API says the token is valid (200 OK),
  /// false if it is not valid (401 Unauthorized: expired or wrong).
  /// Throws [AuthException] if the server can not be reached.
  static Future<bool> checkToken(String token) async {
    final http.Response response;
    try {
      response = await http
          .get(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.checkToken),
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(ApiConstants.timeout);
    } catch (_) {
      throw const AuthException(AppStrings.connectionError);
    }
    return response.statusCode == 200;
  }

  /// Common part of every POST: URL, JSON headers, body and timeout.
  static Future<http.Response> _post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      return await http
          .post(
            Uri.parse(ApiConstants.baseUrl + endpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(ApiConstants.timeout);
    } catch (_) {
      // No internet, server down or timeout
      throw const AuthException(AppStrings.connectionError);
    }
  }

  /// Decodes the JSON body. Every answer has at least { "message": "..." }.
  static Map<String, dynamic> _readJson(http.Response response) {
    try {
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json['message'] is String) return json;
    } catch (_) {
      // The body was not valid JSON
    }
    throw const AuthException(AppStrings.connectionError);
  }
}
