import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../router/app_router.dart';
import '../widgets/drawer_menu.dart';

/// Welcome screen: background image + welcome message + "Empezar" button.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
            ],
          ),
        ),
      ),
    );
  }
}
