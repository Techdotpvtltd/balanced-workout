// Project: 	   balanced_workout
// File:    	   cardio_exercise_screen
// Path:    	   lib/screens/main/user/cardio_exercise_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 20:03:28 -- Tuesday
// Description:

import 'package:balanced_workout/blocs/plan/plan_bloc.dart';
import 'package:balanced_workout/blocs/plan/plan_event.dart';
import 'package:balanced_workout/blocs/plan/plan_state.dart';
import 'package:balanced_workout/models/plan_model.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_network_image.dart';
import '../components/exercise_list_widget.dart';

class CardioExerciseScreen extends StatefulWidget {
  const CardioExerciseScreen({super.key});

  @override
  State<CardioExerciseScreen> createState() => _CardioExerciseScreenState();
}

class _CardioExerciseScreenState extends State<CardioExerciseScreen> {
  PlanModel? cardio;
  bool isLoading = false;

  void triggerFetchCardioEvent() {
    context.read<PlanBloc>().add(PlanEventFetchCardio());
  }

  @override
  void initState() {
    triggerFetchCardioEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) {
        if (state is PlanStateCardioFetchFailure ||
            state is PlanStateCardioFetched ||
            state is PlanStateCardioFetching) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is PlanStateCardioFetchFailure) {
            debugPrint(state.exception.message);
          }
          if (state is PlanStateCardioFetched) {
            setState(() {
              cardio = state.cardio;
            });
          }
        }
      },
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
                        imageUrl: cardio?.coverUrl ?? "",
                      ),
                    ),
                  ),
                ),

                /// Custom App Bar
                customAppBar(title: "Cardio Exercises"),
              ],
            ),

            /// Contents
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 30, left: 29, right: 29),
                child: Skeletonizer(
                  enabled: isLoading,
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
                                  cardio?.difficultyLevel.name
                                          .firstCapitalize() ??
                                      "-",
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
                                  (cardio?.exercises.length ?? 0).toString(),
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
                                  cardio?.exercises
                                          .map((e) => e.exercise.duration)
                                          .reduce((a, b) => a + b)
                                          .formatTime() ??
                                      "00:00",
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
                      ExerciseListWidget(
                        planExercises: cardio?.exercises ?? [],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
