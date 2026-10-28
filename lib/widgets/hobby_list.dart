import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../data/hobbies.dart';
import 'hobby_item.dart';

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
