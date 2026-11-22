import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/router/app_router.dart';
import 'package:pgl_p2_myportfolio/core/services/auth_service.dart';
import 'package:pgl_p2_myportfolio/core/services/token_storage_service.dart';
import 'package:pgl_p2_myportfolio/core/widgets/drawer_menu.dart';
import 'package:pgl_p2_myportfolio/core/widgets/response_dialog.dart';

/// Welcome screen: background image + welcome message + "Empezar" button
/// + button that asks the API for the personal welcome message.
/// StatefulWidget because the API button has a loading state.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // true while we wait for GET /users/welcome
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is also visible behind the (transparent) AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const DrawerMenu(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppStrings.welcomeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Darkens the image so the text can be read
          color: Colors.black.withValues(alpha: 0.35),
          padding: const EdgeInsets.all(AppSizes.spacingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                color: AppColors.textOnPrimary,
                size: AppSizes.welcomeIcon,
              ),
              const SizedBox(height: AppSizes.paddingLarge),
              const Text(
                AppStrings.welcomeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textOnPrimary,
                  fontSize: AppSizes.welcomeTitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.spacing),
              const Text(
                AppStrings.welcomeSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textOnPrimary, fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text(AppStrings.startButton),
                // go_router: go to the portfolio
                onPressed: () => context.go(AppRoutes.portfolio),
              ),
              const SizedBox(height: AppSizes.spacing),

              // Asks the API (protected route) for the personal welcome
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.text,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                icon: _isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.text,
                        ),
                      )
                    : const Icon(Icons.waving_hand),
                label: const Text(AppStrings.welcomeMessageButton),
                onPressed: _isLoading ? null : _showWelcomeMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reads the saved token, calls GET /users/welcome and shows the answer.
  /// If the session has expired (401), the token is deleted and the user
  /// goes back to the login screen after closing the alert.
  Future<void> _showWelcomeMessage() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final TokenStorageService storage = TokenStorageService.getInstance();
    String message;
    bool success = false;
    bool sessionExpired = false;

    try {
      final String? token = await storage.getToken();
      if (token == null) {
        message = AppStrings.noSession;
        sessionExpired = true;
      } else {
        message = await AuthService.welcome(token);
        success = true;
      }
    } on UnauthorizedException {
      // The JWT lasts 1 hour: after that the API answers 401
      try {
        await storage.deleteToken();
      } catch (_) {
        // Even if it fails, the user goes back to login
      }
      message = AppStrings.sessionExpired;
      sessionExpired = true;
    } on AuthException catch (e) {
      message = e.message;
    } catch (_) {
      message = AppStrings.connectionError;
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    await showResponseDialog(context, success: success, message: message);

    if (!sessionExpired || !mounted) return;
    context.go(AppRoutes.login);
  }
}
