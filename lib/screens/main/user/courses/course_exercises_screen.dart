// Project: 	   balanced_workout
// File:    	   course_exercises_screen
// Path:    	   lib/screens/main/user/courses/course_exercises_screen.dart
// Author:       Ali Akbar
// Date:        09-07-24 15:55:36 -- Tuesday
// Description:

import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_paddings.dart';
import 'package:balanced_workout/screens/components/custom_scaffold.dart';
import 'package:balanced_workout/screens/main/user/components/exercise_list_widget.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:flutter/material.dart';

import '../../../../models/plan_exercise_model.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';

class CourseExercisesScreen extends StatefulWidget {
  const CourseExercisesScreen(
      {super.key,
      required this.day,
      required this.week,
      required this.planExercises});
  final int day, week;
  final List<PlanExercise> planExercises;
  @override
  State<CourseExercisesScreen> createState() => _CourseExercisesScreenState();
}

class _CourseExercisesScreenState extends State<CourseExercisesScreen> {
  late final List<PlanExercise> planExercises = widget.planExercises;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        title: "Course Exercises",
      ),
      body: CustomPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              decoration: const BoxDecoration(
                color: AppTheme.darkWidgetColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  /// Week
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Colors.grey,
                        size: 24,
                      ),
                      gapW10,
                      const Text(
                        "Week",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        (widget.week + 1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  gapH10,

                  /// Day
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sunny,
                        color: Colors.grey,
                        size: 24,
                      ),
                      gapW10,
                      const Text(
                        "Day",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        (widget.day).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  gapH10,

                  /// Exercises Number
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.numbers,
                        color: Colors.grey,
                        size: 24,
                      ),
                      gapW10,
                      const Text(
                        "Exercises",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        (planExercises.length).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gapH20,
            const Text(
              "Exercises",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: ExerciseListWidget(
                planExercises: planExercises,
                type: PlanType.course,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
