// Project: 	   balanced_workout
// File:    	   activity_level_screen
// Path:    	   lib/screens/main/user/activity_level_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 20:02:40 -- Monday
// Description:

import 'package:balanced_workout/screens/main/user/courses/progress_course_screen.dart';
import 'package:balanced_workout/screens/main/user/workouts/workout_exercises_screen.dart';
import 'package:balanced_workout/utils/constants/app_assets.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'components/product_card.dart';

class ActivityLevelScreen extends StatelessWidget {
  ActivityLevelScreen({super.key, required this.type, this.selectedPeriod});
  final ScreenType type;
  final List<Level> items = Level.values;
  final Period? selectedPeriod;

  final images = [
    AppAssets.beginnersLevel,
    AppAssets.intermedianLevel,
    AppAssets.advancedLevel,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Difficulty Level",
      ),
      body: ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding:
            const EdgeInsets.only(bottom: 30, left: 29, right: 29, top: 20),
        itemBuilder: (context, index) {
          return ProductCard(
            title: items[index].name.firstCapitalize(),
            isAsset: true,
            onClickCard: () {
              if (type == ScreenType.workout) {
                NavigationService.go(WorkoutExercisesScreen(
                  selectedLevel: items[index],
                ));
              }

              if (type == ScreenType.courses) {
                NavigationService.go(ProgressCourseScreen(
                    selectedLevel: items[index],
                    selectedPeriod: selectedPeriod ?? Period.weekly));
              }
            },
            coverUrl: images[index],
          );
        },
      ),
    );
  }
}
