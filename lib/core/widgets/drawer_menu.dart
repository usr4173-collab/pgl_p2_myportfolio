import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_colors.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/core/router/app_router.dart';
import 'package:pgl_p2_myportfolio/core/services/token_storage_service.dart';

/// Side menu (Drawer) shared by all the screens.
/// It navigates with go_router and highlights the current screen.
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Path of the screen that is open now (for example "/portfolio")
    final String currentPath = GoRouterState.of(context).uri.path;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Orange header with the icon and the app name
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: AppColors.textOnPrimary,
                  size: AppSizes.drawerIcon,
                ),
                SizedBox(height: 8),
                Text(
                  AppStrings.appTitle,
                  style: TextStyle(color: AppColors.textOnPrimary, fontSize: 22),
                ),
              ],
            ),
          ),
          _DrawerItem(
            icon: Icons.home,
            text: AppStrings.menuHome,
            route: AppRoutes.welcome,
            selected: currentPath == AppRoutes.welcome,
          ),
          _DrawerItem(
            icon: Icons.person,
            text: AppStrings.menuPortfolio,
            route: AppRoutes.portfolio,
            selected: currentPath == AppRoutes.portfolio,
          ),
          _DrawerItem(
            icon: Icons.lunch_dining,
            text: AppStrings.menuDishes,
            route: AppRoutes.dishes,
            selected: currentPath == AppRoutes.dishes,
          ),
          _DrawerItem(
            icon: Icons.settings,
            text: AppStrings.menuSettings,
            route: AppRoutes.settings,
            selected: currentPath == AppRoutes.settings,
          ),
          const Divider(),
          // Logout: deletes the token and goes back to the login screen
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text(
              AppStrings.menuLogout,
              style: TextStyle(color: AppColors.error),
            ),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  /// Deletes the session token from the secure storage and goes to login.
  Future<void> _logout(BuildContext context) async {
    // Take the router BEFORE closing the drawer: after pop() this context
    // belongs to a widget that is no longer on screen
    final GoRouter router = GoRouter.of(context);
    Navigator.pop(context); // close the drawer

    try {
      await TokenStorageService.getInstance().deleteToken();
    } catch (_) {
      // Even if the storage fails, the user leaves the private screens
    }

    // go() replaces the whole stack: "back" can not return to the app
    router.go(AppRoutes.login);
  }
}

/// One option of the menu. The selected one has a light yellow background.
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String route;
  final bool selected;

  const _DrawerItem({
    required this.icon,
    required this.text,
    required this.route,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: AppColors.secondary.withValues(alpha: 0.2),
      selectedColor: AppColors.primary,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(text),
      onTap: () {
        Navigator.pop(context); // close the drawer
        context.go(route); // go_router: change screen
      },
    );
  }
}
