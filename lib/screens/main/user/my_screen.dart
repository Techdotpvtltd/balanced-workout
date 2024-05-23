// Project: 	   balanced_workout
// File:    	   my_screen
// Path:    	   lib/screens/main/user/my_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 16:14:48 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'completed_screen.dart';
import 'components/max_stats_screen.dart';
import 'components/navigation_button.dart';
import 'components/recent_muscle_workout.dart';
import 'my_data_screen.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final List<Map<String, String>> data = [
    {
      "title": "Completed Workout\nand Challenges",
      "icon": AppAssets.backgroundDumbbellIcon,
    },
    {
      "title": "Recently Worked\nMuscles",
      "icon": AppAssets.backgroundMusclesIcon,
    },
    {
      "title": "My Data",
      "icon": AppAssets.backgroundProfileIcon,
    },
    {
      "title": "Max Stats",
      "icon": AppAssets.backgroundDatabaseIcon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        topPadding: 50,
        title: "Me",
        showBack: false,
        leftPadding: 29,
        rightPadding: 29,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Buttons
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SmallNavigationButton(
                          title: "Completed Workout and Challenges",
                          icon: AppAssets.backgroundDumbbellIcon,
                          onPressed: () {
                            NavigationService.go(const CompletedScreen());
                          },
                        ),
                      ),
                      gapW8,
                      Expanded(
                        child: SmallNavigationButton(
                          title: "My Data",
                          icon: AppAssets.backgroundDumbbellIcon,
                          onPressed: () {
                            NavigationService.go(const MyDataScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                  gapH30,
                  // Recent Workout
                  const Text(
                    "Recently Worked Muscles",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            gapH20,
            const RecentMuscleWorkout(),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH30,
                  // Recent Workout
                  Text(
                    "Max Stats",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  gapH20,
                  MaxStatsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
