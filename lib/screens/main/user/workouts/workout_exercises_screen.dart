// Project: 	   balanced_workout
// File:    	   workout_exercises_screen
// Path:    	   lib/screens/main/user/workouts/workout_exercises_screen.dart
// Author:       Ali Akbar
// Date:        06-07-24 11:01:40 -- Saturday
// Description:

import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/models/workout_model.dart';
import 'package:balanced_workout/screens/main/user/components/exercise_list_widget.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_network_image.dart';

class WorkoutExercisesScreen extends StatefulWidget {
  const WorkoutExercisesScreen({super.key, required this.workout});
  final WorkoutModel workout;

  @override
  State<WorkoutExercisesScreen> createState() => _WorkoutExercisesScreenState();
}

class _WorkoutExercisesScreenState extends State<WorkoutExercisesScreen> {
  late final WorkoutModel workout = widget.workout;

  void triggerSaveWorkoutLogEvent() {
    context.read<LogBloc>().add(LogEventSaveWorkout(
        workoutId: workout.uuid,
        name: workout.name,
        coverUrl: workout.coverUrl,
        difficultyLevel: workout.difficultyLevel));
  }

  @override
  void initState() {
    triggerSaveWorkoutLogEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                /// Color Blur Widget
                child: SizedBox(
                  height: SCREEN_HEIGHT * 0.3,
                  width: SCREEN_WIDTH,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.srcOver),

                    /// Background Image
                    child: CustomNetworkImage(
                      imageUrl: workout.coverUrl ?? "",
                    ),
                  ),
                ),
              ),

              /// Custom App Bar
              customAppBar(title: workout.name),
            ],
          ),

          /// Contents
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 30, left: 29, right: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Details
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
                        /// Difficulty Level
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 24,
                            ),
                            gapW10,
                            const Text(
                              "Difficulty",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              workout.difficultyLevel.name.firstCapitalize(),
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
                              (workout.exercises.length).toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        gapH10,

                        /// Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                              size: 24,
                            ),
                            gapW10,
                            const Text(
                              "Time (mm:ss)",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              workout.exercises
                                  .map((e) => e.exercise.duration)
                                  .reduce((a, b) => a + b)
                                  .formatTime(),
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
                  gapH14,

                  /// Play List Widget
                  ExerciseListWidget(
                    planExercises: workout.exercises,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
