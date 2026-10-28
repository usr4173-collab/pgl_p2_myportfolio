import 'package:flutter/material.dart';

import 'constants/app_strings.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

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
