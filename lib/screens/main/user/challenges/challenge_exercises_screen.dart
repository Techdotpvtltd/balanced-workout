// Project: 	   balanced_workout
// File:    	   challenge_exercises_screen
// Path:    	   lib/screens/main/user/challenges/challenge_exercises_screen.dart
// Author:       Ali Akbar
// Date:        06-07-24 10:55:08 -- Saturday
// Description:

import 'package:balanced_workout/blocs/plan/plan_bloc.dart';
import 'package:balanced_workout/blocs/plan/plan_event.dart';
import 'package:balanced_workout/blocs/plan/plan_state.dart';
import 'package:balanced_workout/models/plan_model.dart';
import 'package:balanced_workout/screens/main/user/components/exercise_list_widget.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_network_image.dart';

class ChallengeExerciseScreen extends StatefulWidget {
  const ChallengeExerciseScreen({super.key});

  @override
  State<ChallengeExerciseScreen> createState() =>
      _ChallengeExerciseScreenState();
}

class _ChallengeExerciseScreenState extends State<ChallengeExerciseScreen> {
  PlanModel? challenge;
  bool isLoading = false;

  void triggerFetchChallengeEvent() {
    context.read<PlanBloc>().add(PlanEventFetchChallenge());
  }

  @override
  void initState() {
    triggerFetchChallengeEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) {
        if (state is PlanStateChallengeFetchFailure ||
            state is PlanStateChallengeFetched ||
            state is PlanStateChallengeFetching) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is PlanStateChallengeFetchFailure) {
            debugPrint(state.exception.message);
          }
          if (state is PlanStateChallengeFetched) {
            setState(() {
              challenge = state.challenge;
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
                        imageUrl: challenge?.coverUrl ?? "",
                      ),
                    ),
                  ),
                ),

                /// Custom App Bar
                customAppBar(title: "Challenge Exercises"),
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
                                  challenge?.difficultyLevel.name
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
                                  (challenge?.exercises.length ?? 0).toString(),
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
                                  challenge?.exercises
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

                      /// Play List Widget
                      ExerciseListWidget(
                        planExercises: challenge?.exercises ?? [],
                        type: PlanType.challenge,
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
