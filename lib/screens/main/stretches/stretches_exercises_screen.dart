// Project: 	   balanced_workout
// File:    	   stretches_exercises_screen
// Path:    	   lib/screens/main/stretches/stretches_exercises_screen.dart
// Author:       Ali Akbar
// Date:        05-07-24 20:03:18 -- Friday
// Description:
import 'package:balanced_workout/blocs/plan/plan_bloc.dart';
import 'package:balanced_workout/blocs/plan/plan_event.dart';
import 'package:balanced_workout/blocs/plan/plan_state.dart';
import 'package:balanced_workout/models/plan_model.dart';
import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_ink_well.dart';
import 'package:balanced_workout/screens/main/user/exercises/exercise_play_screen.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../components/custom_network_image.dart';

class StretchesExercisesScreen extends StatefulWidget {
  const StretchesExercisesScreen({super.key});

  @override
  State<StretchesExercisesScreen> createState() =>
      _StretchesExercisesScreenState();
}

class _StretchesExercisesScreenState extends State<StretchesExercisesScreen> {
  PlanModel? stretches;
  bool isLoading = false;

  void triggerFetchStretchesEvent() {
    context.read<PlanBloc>().add(PlanEventFetchStretches());
  }

  @override
  void initState() {
    triggerFetchStretchesEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanBloc, PlanState>(
      listener: (context, state) {
        if (state is PlanStateStretchesFetchFailure ||
            state is PlanStateStretchesFetched ||
            state is PlanStateStretchesFetching) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is PlanStateStretchesFetchFailure) {
            debugPrint(state.exception.message);
          }
          if (state is PlanStateStretchesFetched) {
            setState(() {
              stretches = state.stretches;
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
                        imageUrl: stretches?.coverUrl ?? "",
                      ),
                    ),
                  ),
                ),

                /// Custom App Bar
                customAppBar(
                  title: "Stretches Exercises",
                ),
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
                                  stretches?.difficultyLevel.name
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
                                  (stretches?.exercises.length ?? 0).toString(),
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
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                                gapW10,
                                Text(
                                  "Time",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "---",
                                  style: TextStyle(
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
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount:
                            isLoading ? 15 : (stretches?.exercises.length ?? 0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final PlanExercise? planExer =
                              stretches?.exercises[index];

                          return CustomInkWell(
                            onTap: () {
                              NavigationService.go(
                                ExercisePlayScreen(
                                  planExercises: stretches?.exercises ?? [],
                                  currentExercise: planExer,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF303030),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          planExer?.exercise.name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),

                                        /// Time Zone View
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppAssets.clockIcon),
                                            gapW8,
                                            Text(
                                              planExer?.exercise.duration
                                                      .toString() ??
                                                  "",
                                              style: const TextStyle(
                                                color: Color(0xFF8C8C8C),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
