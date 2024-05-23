// Project: 	   balanced_workout
// File:    	   max_stats_screen
// Path:    	   lib/screens/main/user/max_stats_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 18:30:52 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../components/custom_container.dart';

class MaxStatsWidget extends StatelessWidget {
  const MaxStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> data = [
      "Push ups",
      "Pull ups",
      "Squats",
      "Planks",
    ];
    return GridView.custom(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: CustomContainer(
            color: AppTheme.darkWidgetColor,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "25",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                Text(
                  data[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        childCount: data.length,
      ),
    );
  }
}
