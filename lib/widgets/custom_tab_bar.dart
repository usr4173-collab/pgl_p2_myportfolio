import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Data of one tab: icon + text.
class TabItem {
  final IconData icon;
  final String text;

  const TabItem({required this.icon, required this.text});
}

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TabItem> tabs;

  const CustomTabBar({super.key, required this.tabs});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: AppColors.textOnPrimary,
      unselectedLabelColor: Colors.white70,
      indicatorColor: AppColors.secondary,
      indicatorWeight: 3,
      tabs: [
        for (final tab in tabs) Tab(icon: Icon(tab.icon), text: tab.text),
      ],
    );
  }
}
