// Project: 	   balanced_workout
// File:    	   completed_screen
// Path:    	   lib/screens/main/user/completed_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 16:36:24 -- Wednesday
// Description:

import 'package:balanced_workout/app/cache_manager.dart';
import 'package:balanced_workout/blocs/workout/workout_state.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/workout/workout_bloc.dart';
import '../../../blocs/workout/workout_event.dart';
import '../../../models/logs/exercise_log_model.dart';
import '../../../models/logs/workout_log_model.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/dialogs/dialogs.dart';
import '../../../utils/dialogs/loaders.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_container.dart';
import '../../components/custom_ink_well.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_paddings.dart';
import 'components/custom_tab_bar.dart';
import 'log/challenge_log_screen.dart';
import 'workouts/workout_exercises_screen.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool isWorkoutSelected = true;
  late final List<WorkoutLogModel> completedWorkouts =
      CacheLogWorkout().findCompletedWorkouts();
  late final List<ExerciseLogModel> completedChallenfes =
      CacheLogExercise().findBy(PlanType.challenge);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WorkoutBloc, WorkoutState>(listener: (_, state) {
          if (state is WorkoutStateGetFailue ||
              state is WorkoutStateGetting ||
              state is WorkoutStateHGot) {
            state.isLoading ? Loader().show() : Loader().hide();

            if (state is WorkoutStateHGot) {
              NavigationService.go(
                  WorkoutExercisesScreen(workout: state.workout));
            }

            if (state is WorkoutStateGetFailue) {
              CustomDialogs().errorBox(message: state.exception.message);
            }
          }
        })
      ],
      child: Scaffold(
        appBar: customAppBar(
            title:
                'Completed ${isWorkoutSelected ? 'Workouts' : 'Challenges'}'),
        body: CustomPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Tab bar
              CustomTabBar(
                items: const ['Completed Workouts', ' Completed Challenges'],
                onPressed: (index) {
                  setState(() {
                    isWorkoutSelected = index == 0;
                  });
                },
              ),
              gapH36,

              /// Status View
              CustomContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                color: const Color(0xFF1E1E1E),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${isWorkoutSelected ? 'Workouts' : 'Challenges'} Completed',
                      style: const TextStyle(
                        color: AppTheme.primaryColor1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      isWorkoutSelected
                          ? completedWorkouts.length.toString()
                          : completedChallenfes.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              /// Title
              gapH28,
              Text(
                'Completed ${isWorkoutSelected ? 'Workout' : 'Challenges'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: isWorkoutSelected
                      ? completedWorkouts.length
                      : completedChallenfes.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 7, top: 8),
                  itemBuilder: (context, index) {
                    return isWorkoutSelected
                        ? CustomInkWell(
                            onTap: () {
                              context.read<WorkoutBloc>().add(WorkoutEventGet(
                                  uuid: completedWorkouts[index].workoutId));
                            },
                            child: Container(
                              height: 193,
                              margin: const EdgeInsets.only(top: 7, bottom: 7),
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                color: AppTheme.darkWidgetColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          const Color(0xff000000)
                                              .withOpacity(0.35),
                                          BlendMode.srcOver),
                                      child: CustomNetworkImage(
                                        imageUrl:
                                            completedWorkouts[index].coverUrl ??
                                                "",
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 23,
                                    right: 10,
                                    bottom: 10,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            completedWorkouts[index].name,
                                            maxLines: 3,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : CustomInkWell(
                            onTap: () {
                              NavigationService.go(const ChallengeLogScreen());
                            },
                            child: Container(
                              height: 193,
                              padding: const EdgeInsets.only(bottom: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 42, 41, 41),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Cover View
                                      CustomNetworkImage(
                                        imageUrl:
                                            completedChallenfes[index].coverUrl,
                                        width: SCREEN_WIDTH,
                                        height: constraints.maxHeight * 0.7,
                                      ),
                                      gapH6,

                                      /// Title
                                      HorizontalPadding(
                                        value: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                completedChallenfes[index]
                                                    .title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
