// Project: 	   balanced_workout
// File:    	   height_screen
// Path:    	   lib/screens/onboarding/height_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 17:40:35 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'goal_screen.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "What’s your height?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: WheelValuePicker(
        data: List.generate(81, (index) => (index + 130).toString()),
        unit: "cm",
      ),
      onPressedNext: () {
        NavigationService.go(const GoalScreen());
      },
    );
  }
}
