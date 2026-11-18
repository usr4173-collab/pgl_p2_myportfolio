import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/router/app_router.dart';
import 'package:pgl_p2_myportfolio/core/theme/app_theme.dart';

void main() {
  runApp(const MyPortfolioApp());
}

/// App root: sets up the theme and the router (go_router).
class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router uses go_router to decide which screen is shown.
    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
