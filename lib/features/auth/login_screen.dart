import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/router/app_router.dart';
import 'package:pgl_p2_myportfolio/core/services/auth_service.dart';
import 'package:pgl_p2_myportfolio/core/services/token_storage_service.dart';
import 'package:pgl_p2_myportfolio/core/widgets/response_dialog.dart';
import 'package:pgl_p2_myportfolio/features/auth/widgets/auth_input_decoration.dart';

/// Login screen: text inputs for email and password.
/// StatefulWidget because it owns the TextEditingControllers.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Later we read .text to send them to POST /users/login
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // true while we wait for the API (spinner + button disabled)
  bool _isLoading = false;

  // true while we check if there is a valid saved session (on app start)
  bool _checkingSession = true;

  @override
  void initState() {
    super.initState();
    _checkSavedSession();
  }

  /// On app start: is there a saved token? Is it still valid in the API?
  /// - Valid token   -> go to the welcome screen automatically.
  /// - Invalid token -> delete it and show the login form.
  /// - No token / no connection -> show the login form.
  Future<void> _checkSavedSession() async {
    final TokenStorageService storage = TokenStorageService.getInstance();
    bool validSession = false;

    try {
      final String? token = await storage.getToken();
      if (token != null) {
        validSession = await AuthService.checkToken(token);
        // Expired or wrong token: it is useless, remove it
        if (!validSession) await storage.deleteToken();
      }
    } catch (_) {
      // No connection or storage error: the user logs in by hand
      validSession = false;
    }

    if (!mounted) return;
    if (validSession) {
      context.go(AppRoutes.welcome);
    } else {
      setState(() => _checkingSession = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While checking the saved session, show only a spinner
    // (so the form does not appear and disappear)
    if (_checkingSession) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColors.primary),
              SizedBox(height: AppSizes.spacing),
              Text(AppStrings.checkingSession),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      // No drawer: until the user logs in, only login/register are reachable
      appBar: AppBar(
        title: const Text(AppStrings.loginTitle),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.login,
              color: AppColors.primary,
              size: AppSizes.welcomeIcon,
            ),
            const SizedBox(height: AppSizes.spacingLarge),

            // Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: authInputDecoration(AppStrings.email, Icons.email),
            ),
            const SizedBox(height: AppSizes.spacing),

            // Password (hidden characters)
            TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.done,
              decoration: authInputDecoration(AppStrings.password, Icons.lock),
              // Pressing "done" on the keyboard also sends the form
              onSubmitted: (_) => _login(),
            ),
            const SizedBox(height: AppSizes.spacingLarge),

            // Login button: disabled (null) while the request is running
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                ),
              ),
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textOnPrimary,
                      ),
                    )
                  : const Text(AppStrings.loginButton),
            ),
            const SizedBox(height: AppSizes.spacing),

            // Link-style button to the register screen
            TextButton(
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              onPressed: () => context.go(AppRoutes.register),
              child: const Text(AppStrings.goToRegister),
            ),
          ],
        ),
      ),
    );
  }

  /// Sends email + password to the API and shows the answer in an alert.
  Future<void> _login() async {
    if (_isLoading) return; // avoids sending the form twice
    FocusScope.of(context).unfocus(); // hide the keyboard
    setState(() => _isLoading = true);

    String message;
    bool success;
    try {
      final LoginResponse response = await AuthService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Save the JWT securely before telling the user that all went well
      await TokenStorageService.getInstance().saveToken(response.token);
      message = response.message;
      success = true;
    } on AuthException catch (e) {
      message = e.message;
      success = false;
    } catch (_) {
      // The secure storage failed: the session could not be saved
      message = AppStrings.tokenSaveError;
      success = false;
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    await showResponseDialog(context, success: success, message: message);

    // Successful login (token already saved): enter the app
    if (!success || !mounted) return;
    context.go(AppRoutes.welcome);
  }
}
