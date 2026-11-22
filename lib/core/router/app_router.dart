import 'package:go_router/go_router.dart';

import 'package:pgl_p2_myportfolio/features/auth/login_screen.dart';
import 'package:pgl_p2_myportfolio/features/auth/register_screen.dart';
import 'package:pgl_p2_myportfolio/features/dishes/dishes_screen.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/portfolio_screen.dart';
import 'package:pgl_p2_myportfolio/features/settings/settings_screen.dart';
import 'package:pgl_p2_myportfolio/features/welcome/welcome_screen.dart';

/// Route paths. Using constants avoids typing the same text in several places.
class AppRoutes {
  static const String welcome = '/';
  static const String portfolio = '/portfolio';
  static const String dishes = '/dishes';
  static const String settings = '/settings';
  static const String register = '/register';
  static const String login = '/login';
}

/// App navigation with go_router.
/// Each GoRoute links a path with the screen that is shown.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.portfolio,
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      path: AppRoutes.dishes,
      builder: (context, state) => const DishesScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
