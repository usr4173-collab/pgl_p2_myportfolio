import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../router/app_router.dart';

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
        ],
      ),
    );
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
