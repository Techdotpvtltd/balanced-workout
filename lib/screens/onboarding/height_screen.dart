// Project: 	   balanced_workout
// File:    	   height_screen
// Path:    	   lib/screens/onboarding/height_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 17:40:35 -- Saturday
// Description:

import 'package:flutter/material.dart';
import '../../app/app_manager.dart';
import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'profile_activity_level.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> data =
        List.generate(81, (index) => (index + 130).toString());
    int height = 130;
    return InformationWidget(
      title: "What’s your height?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: WheelValuePicker(
        data: data,
        unit: "cm",
        onIndexChanged: (index) {
          height = int.tryParse(data[index]) ?? 0;
        },
      ),
      onPressedNext: () {
        AppManager().user = AppManager().user.copyWith(height: height);
        NavigationService.go(const ProfileActivityLevelScreen());
      },
    );
  }
}
