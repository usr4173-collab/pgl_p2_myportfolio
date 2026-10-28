import 'package:go_router/go_router.dart';

import '../screens/portfolio_screen.dart';
import '../screens/welcome_screen.dart';

/// Route paths. Using constants avoids typing the same text in several places.
class AppRoutes {
  static const String welcome = '/';
  static const String portfolio = '/portfolio';
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
  ],
);
