import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_strings.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/widgets/custom_tab_bar.dart';
import 'package:pgl_p2_myportfolio/core/widgets/drawer_menu.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/widgets/hobby_list.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/widgets/presentation.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/widgets/repository.dart';


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
