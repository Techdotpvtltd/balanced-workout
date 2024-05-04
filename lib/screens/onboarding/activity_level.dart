// Project: 	   balanced_workout
// File:    	   activity_level
// Path:    	   lib/screens/onboarding/activity_level.dart
// Author:       Ali Akbar
// Date:        04-05-24 18:00:50 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'profile_picker_screen.dart';

class ActivityLevelScreen extends StatelessWidget {
  const ActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "Your regular physical\nactivity level?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: const WheelValuePicker(
        data: [
          "Rookie",
          "Beginner",
          "Intermediate",
          "Advance",
          "True Beast",
          "Pro",
          "Mastery",
        ],
        isSmallText: true,
      ),
      onPressedNext: () {
        NavigationService.go(const ProfilePickerScreen());
      },
    );
  }
}
