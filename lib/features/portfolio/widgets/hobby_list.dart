import 'package:flutter/material.dart';

import 'package:pgl_p2_myportfolio/core/constants/app_sizes.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/data/hobbies.dart';
import 'package:pgl_p2_myportfolio/features/portfolio/widgets/hobby_item.dart';

/// "Mis hobbies" tab: one card for each hobby in the list.
class HobbyList extends StatelessWidget {
  const HobbyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.padding),
      itemCount: hobbies.length,
      itemBuilder: (context, index) => HobbyItem(hobby: hobbies[index]),
    );
  }
}
