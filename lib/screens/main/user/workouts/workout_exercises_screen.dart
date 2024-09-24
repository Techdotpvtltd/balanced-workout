// Project: 	   balanced_workout
// File:    	   workout_exercises_screen
// Path:    	   lib/screens/main/user/workouts/workout_exercises_screen.dart
// Author:       Ali Akbar
// Date:        06-07-24 11:01:40 -- Saturday
// Description:

import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/blocs/log/log_state.dart';
import 'package:balanced_workout/models/workout_model.dart';

import 'package:balanced_workout/utils/dialogs/dialogs.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/plan_exercise_model.dart';
import '../../../../models/workout_round_model.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import 'workout_play_exercises_screen.dart';

class WorkoutExercisesScreen extends StatefulWidget {
  const WorkoutExercisesScreen({super.key, required this.workout});
  final WorkoutModel workout;

  @override
  State<WorkoutExercisesScreen> createState() => _WorkoutExercisesScreenState();
}

class _WorkoutExercisesScreenState extends State<WorkoutExercisesScreen> {
  late final WorkoutModel workout = widget.workout;

  void triggerSaveWorkoutLogEvent() {
    context.read<LogBloc>().add(
          LogEventSaveWorkout(
            workoutId: workout.uuid,
            name: workout.name,
            coverUrl: workout.coverUrl,
            difficultyLevel: workout.difficultyLevel,
          ),
        );
  }

  void triggerMarkWorkoutCompleteEvent() {
    context
        .read<LogBloc>()
        .add(LogEventMarkWorkoutComplete(workoutId: workout.uuid));
  }

  @override
  void initState() {
    triggerSaveWorkoutLogEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// WorkoutBloc
        BlocListener<LogBloc, LogState>(
          listener: (_, state) {
            if (state is LogStateMarkCompleted) {
              CustomDialogs().successBox(
                  title: "Great Work!", message: "You completed this workout.");
            }
          },
        ),
      ],
      child: Scaffold(
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
                                "Rounds",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                (workout.rounds.length).toString(),
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
                    for (int round = 0; round < workout.rounds.length; round++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Round ${round + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          gapH2,
                          // Play List Widget
                          _ExerciseListWidget(
                            round: workout.rounds[round],
                            onCompletePressed: () {
                              triggerMarkWorkoutCompleteEvent();
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseListWidget extends StatefulWidget {
  const _ExerciseListWidget({
    this.onCompletePressed,
    required this.round,
  });
  final VoidCallback? onCompletePressed;
  final WorkoutRoundModel round;
  @override
  State<_ExerciseListWidget> createState() => _ExerciseListWidgetState();
}

class _ExerciseListWidgetState extends State<_ExerciseListWidget> {
  late List<PlanExercise> planExercises = widget.round.exercises;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: planExercises.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        final PlanExercise planExercise = planExercises[index];

        return CustomInkWell(
          onTap: () {
            final exercises = List<PlanExercise>.from(planExercises)
                .skipWhile((e) => e.uuid != planExercise.uuid)
                .toList();

            NavigationService.go(
              WorkoutPlayExercisesScreen(
                onCompleteButton: widget.onCompletePressed,
                planExercises: exercises,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF303030),
              borderRadius: BorderRadius.all(Radius.circular(36)),
            ),
            child: Row(
              children: [
                /// Play Button
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor1,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 26,
                  ),
                ),
                gapW16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planExercise.exercise.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
