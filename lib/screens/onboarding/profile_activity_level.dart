// Project: 	   balanced_workout
// File:    	   activity_level
// Path:    	   lib/screens/onboarding/activity_level.dart
// Author:       Ali Akbar
// Date:        04-05-24 18:00:50 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../app/app_manager.dart';
import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'profile_picker_screen.dart';

class ProfileActivityLevelScreen extends StatelessWidget {
  const ProfileActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> activities = [
      "Rookie",
      "Beginner",
      "Intermediate",
      "Advance",
      "True Beast",
      "Pro",
      "Mastery",
    ];
    int index = 0;

    return InformationWidget(
      title: "Your regular physical\nactivity level?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: WheelValuePicker(
        data: activities,
        isSmallText: true,
        onIndexChanged: (i) {
          index = i;
        },
      ),
      onPressedNext: () {
        AppManager().user = AppManager()
            .user
            .copyWith(activityLevel: activities[index].toLowerCase());
        NavigationService.go(const ProfilePickerScreen());
      },
    );
  }
}
