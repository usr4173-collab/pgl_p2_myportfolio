import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../router/app_router.dart';
import '../widgets/app_logo.dart';
import '../widgets/drawer_menu.dart';

/// Welcome screen: background image, logo, welcome message and "Comenzar" button.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is also drawn behind the (transparent) AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const DrawerMenu(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background image
          Image.asset(AppStrings.welcomeBackground, fit: BoxFit.cover),
          // 2. Dark gradient so the text can be read
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.15),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          // 3. Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: AppSizes.spacingLarge,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  const AppLogo(size: AppSizes.welcomeLogo),
                  const Spacer(flex: 2),
                  const Text(
                    AppStrings.welcomeTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing),
                  const Text(
                    AppStrings.welcomeSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textOnPrimary, fontSize: AppSizes.textSize),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textOnPrimary,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => context.go(AppRoutes.portfolio),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.startButton, style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
