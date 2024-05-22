// Project: 	   balanced_workout
// File:    	   age_screen
// Path:    	   lib/screens/onboarding/age_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 16:06:07 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../app/app_manager.dart';
import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'weight_screen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int age = 13;
  final List<String> data =
      List.generate(88, (index) => (index + 13).toString());

  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "How old are you?",
      subTitle: "This helps us create your personalized plan",
      middleWidget: WheelValuePicker(
        data: data,
        onIndexChanged: (index) {
          age = int.tryParse(data[index]) ?? 0;
        },
      ),
      onPressedNext: () {
        AppManager().user = AppManager().user.copyWith(age: age);
        NavigationService.go(const WeightScreen());
      },
    );
  }
}
