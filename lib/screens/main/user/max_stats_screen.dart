// Project: 	   balanced_workout
// File:    	   max_stats_screen
// Path:    	   lib/screens/main/user/max_stats_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 18:30:52 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_container.dart';

class MaxStatsScreen extends StatelessWidget {
  const MaxStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Max Stats'),
      body: GridView.custom(
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 22, right: 22, bottom: 10, top: 17),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: CustomContainer(
              color: AppTheme.darkWidgetColor,
              borderRadius: BorderRadius.all(Radius.circular(24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "25",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    "Exercise name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          childCount: 4,
        ),
      ),
    );
  }
}
