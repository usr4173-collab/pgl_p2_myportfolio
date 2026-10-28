import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/hobby_list.dart';
import '../widgets/presentation.dart';
import '../widgets/repository.dart';


class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.portfolioTitle),
          bottom: const CustomTabBar(
            tabs: [
              TabItem(icon: Icons.favorite, text: AppStrings.hobbiesTab),
              TabItem(icon: Icons.qr_code, text: AppStrings.repositoryTab),
            ],
          ),
        ),
        drawer: const DrawerMenu(),
        body: const Column(
          children: [
            Presentation(),
            Expanded(
              child: TabBarView(
                children: [
                  HobbyList(),
                  Repository(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
