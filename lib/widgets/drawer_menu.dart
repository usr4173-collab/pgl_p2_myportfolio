import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../router/app_router.dart';
import 'app_logo.dart';

/// Side menu (Drawer) shared by all the screens.
/// It navigates with go_router and highlights the current screen.
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Path of the screen that is open now (for example "/portfolio")
    final String currentPath = GoRouterState.of(context).uri.path;

    return Drawer(
      width: AppSizes.drawerWidth,
      child: Column(
        children: [
          const _DrawerHeader(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
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
          ),
          const _DrawerFooter(),
        ],
      ),
    );
  }
}

/// Blue header with the logo.
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppSizes.spacingLarge,
        bottom: AppSizes.spacingLarge,
      ),
      child: const AppLogo(size: AppSizes.drawerLogo),
    );
  }
}

/// One option of the menu. The selected one has a light blue background.
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        selected: selected,
        selectedTileColor: AppColors.lightBlue,
        selectedColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(icon),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
        onTap: () {
          Navigator.pop(context); // close the drawer
          context.go(route); // go_router: change screen
        },
      ),
    );
  }
}

/// Small logo at the bottom of the drawer.
class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            AppLogo(size: 32, color: AppColors.primary, showText: false),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appTitle,
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                Text(
                  AppStrings.appSlogan,
                  style: TextStyle(fontSize: 12, color: AppColors.greyText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
