// Project: 	   balanced_workout
// File:    	   progression_screen
// Path:    	   lib/screens/main/user/progression_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 12:51:57 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../components/custom_scaffold.dart';
import 'components/custom_weekly_date.dart';

class ProgressionScreen extends StatelessWidget {
  const ProgressionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        background: const Color(0xFF2C2C2E).withOpacity(0.62),
        title: "Progression",
      ),
      body: Column(
        children: [
          CustomWeeklyDate(
            onSelectedDate: (p0) {},
          ),
        ],
      ),
    );
  }
}
