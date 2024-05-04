// Project: 	   balanced_workout
// File:    	   goal_screen
// Path:    	   lib/screens/onboarding/goal_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 17:44:31 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../utils/extensions/navigation_service.dart';
import 'activity_level.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "What’s your goal?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: const WheelValuePicker(
        data: [
          "Gain Weight",
          "Lose weight",
          "Get fitter",
          "Gain more flexible",
          "Build Muscle",
          "Increase Endurance",
          "Learn the basic",
          "Improve Sleep"
        ],
        isSmallText: true,
      ),
      onPressedNext: () {
        NavigationService.go(const ActivityLevelScreen());
      },
    );
  }
}
