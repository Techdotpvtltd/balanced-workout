// Project: 	   balanced_workout
// File:    	   workout_screen
// Path:    	   lib/screens/main/user/workout_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 15:00:27 -- Monday
// Description:

import 'package:balanced_workout/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'components/navigation_button.dart';

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
                    title: "Progression",
                    onPressed: () {},
                  ),
                ),
                gapW10,
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.exerciseIcon,
                    title: "Courses / Library",
                    onPressed: () {},
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
                    title: "Weekly Plans",
                    onPressed: () {},
                  ),
                ),
                gapW10,
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.cardioIcon,
                    title: "Cardio Exercise",
                    onPressed: () {},
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
                    onPressed: () {},
                  ),
                ),
                gapW10,
                Expanded(
                  child: NavigationButton(
                    icon: AppAssets.challengeIcon,
                    title: "Challenges",
                    onPressed: () {},
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
