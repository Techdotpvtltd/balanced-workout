// Project: 	   balanced_workout
// File:    	   goal_screen
// Path:    	   lib/screens/onboarding/goal_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 17:44:31 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../app/app_manager.dart';
import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'profile_activity_level.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int goalIndex = 0;
    final List<String> goals = [
      "Gain Weight",
      "Lose weight",
      "Get fitter",
      "Gain more flexible",
      "Build Muscle",
      "Increase Endurance",
      "Learn the basic",
      "Improve Sleep"
    ];
    return InformationWidget(
      title: "What’s your goal?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: WheelValuePicker(
        data: goals,
        isSmallText: true,
        onIndexChanged: (index) {
          goalIndex = index;
        },
      ),
      onPressedNext: () {
        AppManager().user =
            AppManager().user.copyWith(goal: goals[goalIndex].toLowerCase());
        NavigationService.go(const ProfileActivityLevelScreen());
      },
    );
  }
}
