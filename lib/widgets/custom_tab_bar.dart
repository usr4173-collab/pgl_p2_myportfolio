import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Tab bar with white background and blue indicator (replaces the old buttons).
/// It goes in AppBar.bottom, so it implements PreferredSizeWidget.
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;

  const CustomTabBar({super.key, required this.tabs});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.greyText,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabs: [for (final text in tabs) Tab(text: text)],
      ),
    );
  }
}
