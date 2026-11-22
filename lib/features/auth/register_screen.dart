import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/router/app_router.dart';
import 'package:pgl_p2_myportfolio/core/services/auth_service.dart';
import 'package:pgl_p2_myportfolio/core/widgets/drawer_menu.dart';
import 'package:pgl_p2_myportfolio/core/widgets/response_dialog.dart';
import 'package:pgl_p2_myportfolio/features/auth/widgets/auth_input_decoration.dart';

/// Register screen: text inputs for full name, email and password.
/// It is a StatefulWidget because it owns the TextEditingControllers
/// (they keep what the user types and must be disposed).
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // One controller per input: later we read .text to send it to the API
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // true while we wait for the API (shows a spinner and blocks the button)
  bool _isLoading = false;

  @override
  void dispose() {
    // Free the controllers when the screen is closed
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.registerTitle)),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        // Scroll so the keyboard never hides the inputs
        padding: const EdgeInsets.all(AppSizes.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.person_add,
              color: AppColors.primary,
              size: AppSizes.welcomeIcon,
            ),
            const SizedBox(height: AppSizes.spacingLarge),

            // Full name
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: authInputDecoration(AppStrings.fullName, Icons.person),
            ),
            const SizedBox(height: AppSizes.spacing),

            // Email: email keyboard (shows the @)
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: authInputDecoration(AppStrings.email, Icons.email),
            ),
            const SizedBox(height: AppSizes.spacing),

            // Password: obscureText hides the characters
            TextField(
              controller: _passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.done,
              decoration: authInputDecoration(AppStrings.password, Icons.lock),
              // Pressing "done" on the keyboard also sends the form
              onSubmitted: (_) => _register(),
            ),
            const SizedBox(height: AppSizes.spacingLarge),

            // Register button: disabled (null) while the request is running
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                ),
              ),
              onPressed: _isLoading ? null : _register,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textOnPrimary,
                      ),
                    )
                  : const Text(AppStrings.registerButton),
            ),
          ],
        ),
      ),
    );
  }

  /// Sends the form data to the API and shows the answer in an alert.
  Future<void> _register() async {
    if (_isLoading) return; // avoids sending the form twice
    FocusScope.of(context).unfocus(); // hide the keyboard
    setState(() => _isLoading = true);

    String message;
    bool success;
    try {
      message = await AuthService.register(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      success = true;
    } on AuthException catch (e) {
      message = e.message;
      success = false;
    }

    // After an await the screen may have been closed: check it is still there
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Any answer (201, 400, 409, 500 or no connection) ends in an alert
    await showResponseDialog(context, success: success, message: message);

    // Only after a successful register (201) and once the user has closed
    // the alert: go to the login screen
    if (!success || !mounted) return;
    context.go(AppRoutes.login);
  }
}
