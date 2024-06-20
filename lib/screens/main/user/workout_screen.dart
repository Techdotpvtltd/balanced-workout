// Project: 	   balanced_workout
// File:    	   workout_screen
// Path:    	   lib/screens/main/user/workout_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 15:00:27 -- Monday
// Description:

import 'package:balanced_workout/screens/main/user/activity_level_screen.dart';
import 'package:balanced_workout/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../app/app_manager.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'components/navigation_button.dart';
import 'period_screen.dart';
import 'playlist_screen.dart';
import 'progression_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Work out",
        showBack: false,
        topPadding: 50,
        leftPadding: 20,
      ),
      body: CustomPadding(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.heartIcon,
                    title: "Basic Movement Patterns",
                    onPressed: () {
                      NavigationService.go(const ProgressionScreen());
                    },
                  ),
                ),
                gapW10,
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.exerciseIcon,
                    title: "Daily Workouts",
                    onPressed: () {
                      NavigationService.go(ActivityLevelScreen());
                      AppManager().screenTitle = "Workout";
                      AppManager().records = [
                        {
                          "Upper Body": [
                            "Push-ups",
                            "Pull-ups",
                            "Bench Press",
                            "Bicep Curls"
                          ]
                        },
                        {
                          "Lower Body": [
                            "Squats",
                            "Lunges",
                            "Deadlifts",
                            "Leg Press"
                          ]
                        },
                        {
                          "Core": [
                            "Planks",
                            "Crunches",
                            "Russian Twists",
                            "Leg Raises"
                          ]
                        },
                      ];
                    },
                  ),
                ),
              ],
            ),
            gapH10,
            Row(
              children: [
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.dumbbellIcon2,
                    title: "Courses",
                    onPressed: () {
                      NavigationService.go(PeriodScreen());
                      AppManager().screenTitle = "Courses";
                      AppManager().records = [
                        {
                          "Strength Training": [
                            "Weights",
                            "Resistance Bands",
                            "Bodyweight Exercises"
                          ]
                        },
                        {
                          "Cardio Workout": ["Running", "Cycling", "Jump Rope"]
                        },
                        {
                          "Yoga Classes": [
                            "Hatha Yoga",
                            "Vinyasa Yoga",
                            "Power Yoga"
                          ]
                        },
                      ];
                    },
                  ),
                ),
                gapW10,
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.cardioIcon,
                    title: "Cardio Exercise",
                    onPressed: () {
                      NavigationService.go(const PlaylistScreen());
                      AppManager().screenTitle = "Cardio Exercise";
                      AppManager().records = [
                        {
                          "Cardio Workout": ["Running", "Cycling", "Jump Rope"]
                        },
                      ];
                    },
                  ),
                ),
              ],
            ),
            gapH10,
            Row(
              children: [
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.stretchesIcon,
                    title: "Stretches",
                    onPressed: () {
                      NavigationService.go(const PlaylistScreen());
                      AppManager().screenTitle = "Stretches";
                      AppManager().records = [
                        {
                          "Neck Stretches": [
                            "Neck Rotation",
                            "Neck Flexion",
                            "Neck Extension"
                          ]
                        },
                        {
                          "Shoulder Stretches": [
                            "Shoulder Roll",
                            "Shoulder Stretch",
                            "Arm Cross"
                          ]
                        },
                        {
                          "Hamstring Stretches": [
                            "Standing Hamstring Stretch",
                            "Seated Hamstring Stretch",
                            "Lying Hamstring Stretch"
                          ]
                        },
                      ];
                    },
                  ),
                ),
                gapW10,
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.challengeIcon,
                    title: "Challenges",
                    onPressed: () {
                      NavigationService.go(const PlaylistScreen());
                      AppManager().screenTitle = "Challenges";
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
