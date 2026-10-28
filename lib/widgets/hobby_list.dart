import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../data/hobbies.dart';
import 'hobby_item.dart';

/// "Hobbies" tab: grid with 2 columns, one card for each hobby.
class HobbyList extends StatelessWidget {
  const HobbyList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      itemCount: hobbies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSizes.spacing,
        crossAxisSpacing: AppSizes.spacing,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) => HobbyItem(hobby: hobbies[index]),
    );
  }
}
