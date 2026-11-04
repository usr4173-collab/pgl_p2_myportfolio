import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

/// Counter that shows the total number of dishes of the list.
/// It is a Badge (small yellow circle with the number) on top of an icon.
class DishCounter extends StatelessWidget {
  final int total;

  const DishCounter({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppStrings.totalDishes,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Badge(
          label: Text('$total'),
          backgroundColor: AppColors.secondary,
          textColor: AppColors.text,
          // The badge is always shown, also when the total is 0
          isLabelVisible: true,
          child: const Icon(Icons.lunch_dining, size: 28),
        ),
      ),
    );
  }
}
