// Project: 	   balanced_workout
// File:    	   my_screen
// Path:    	   lib/screens/main/user/my_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 16:14:48 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'completed_screen.dart';
import 'components/navigation_button.dart';
import 'my_data_screen.dart';
import 'recent_muscle_workout.dart';

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
        topPadding: 60,
        title: "Me",
        showBack: false,
        leftPadding: 29,
        rightPadding: 29,
      ),
      body: GridView.custom(
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 22, right: 22, bottom: 10, top: 17),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: NavigationButton(
              icon: data[index]['icon'] as String,
              title: data[index]['title'] as String,
              onPressed: () {
                if (index == 0) {
                  NavigationService.go(const CompletedScreen());
                }

                if (index == 1) {
                  NavigationService.go(const RecentMuscleWorkout());
                }

                if (index == 2) {
                  NavigationService.go(const MyDataScreen());
                }
              },
            ),
          ),
          childCount: data.length,
        ),
      ),
    );
  }
}
