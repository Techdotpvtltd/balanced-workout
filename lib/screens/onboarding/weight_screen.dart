// Project: 	   balanced_workout
// File:    	   weight_screen
// Path:    	   lib/screens/onboarding/weight_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 17:28:40 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../app/app_manager.dart';
import '../../utils/extensions/navigation_service.dart';
import 'components/information_widget.dart';
import 'components/wheel_value_picker.dart';
import 'height_screen.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> data =
        List.generate(121, (index) => (index + 30).toString());
    int weight = 30;

    return InformationWidget(
      title: "What’s your weight?",
      subTitle: "You can always change this later",
      middleWidget: WheelValuePicker(
        data: data,
        unit: "Kg",
        onIndexChanged: (index) {
          weight = int.tryParse(data[index]) ?? 0;
        },
      ),
      onPressedNext: () {
        AppManager().user = AppManager().user.copyWith(weight: weight);
        NavigationService.go(const HeightScreen());
      },
    );
  }
}
