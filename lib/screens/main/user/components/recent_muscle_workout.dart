// Project: 	   balanced_workout
// File:    	   recent_muscle_workout
// Path:    	   lib/screens/main/user/recent_muscle_workout.dart
// Author:       Ali Akbar
// Date:        08-05-24 17:04:07 -- Wednesday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/constants.dart';
import 'custom_weekly_date.dart';
class RecentMuscleWorkout extends StatelessWidget {
  const RecentMuscleWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Date View
        CustomWeeklyDate(onSelectedDate: (p0) {}),
        gapH50,

        /// Anatomy Image
        Image.asset(
          AppAssets.anatomy,
        ),

        /// Body Parts Color Period Status
        SizedBox(
          height: 50,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20, left: 6, right: 6),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  children: [
                    /// Circle
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: index == 0
                          ? const Color(0xFFFF2424)
                          : index == 1
                              ? const Color(0xFFFBD047)
                              : const Color(0xFFE87A02),
                    ),
                    gapW10,
                    Text(
                      index == 0
                          ? "Yesterday"
                          : index == 1
                              ? "2 Days ago"
                              : "1 Week ago",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
