// Project: 	   balanced_workout
// File:    	   progression_screen
// Path:    	   lib/screens/main/user/progression_screen.dart
// Author:       Ali Akbar
// Date:        08-05-24 12:51:57 -- Wednesday
// Description:

import 'package:balanced_workout/app/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../blocs/log/log_bloc.dart';
import '../../../blocs/log/log_state.dart';
import '../../../blocs/workout/workout_bloc.dart';
import '../../../blocs/workout/workout_event.dart';
import '../../../blocs/workout/workout_state.dart';
import '../../../models/workout_model.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/dialogs/dialogs.dart';
import '../../../utils/dialogs/loaders.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_ink_well.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import 'components/custom_weekly_date.dart';
import 'workouts/workout_exercises_screen.dart';

class ProgressionScreen extends StatefulWidget {
  const ProgressionScreen({super.key});

  @override
  State<ProgressionScreen> createState() => _ProgressionScreenState();
}

class _ProgressionScreenState extends State<ProgressionScreen> {
  late List<dynamic> workouts = CacheLogWorkout().fetchAllAt(DateTime.now());
  bool isLoading = false;

  void fetchAllAt(DateTime selectedDate) {
    setState(() {
      workouts = CacheLogWorkout().fetchAllAt(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// Log Bloc

        BlocListener<LogBloc, LogState>(
          listener: (_, state) {
            if (state is LogStateWorkoutsFetching ||
                state is LogStateWorkoutsFetched ||
                state is LogStateWorkoutsFetchFailure) {
              setState(() {
                isLoading = state.isLoading;
              });

              if (state is LogStateWorkoutsFetched) {
                setState(() {
                  workouts = state.workouts;
                });
              }

              if (state is LogStateWorkoutsFetchFailure) {
                CustomDialogs().errorBox(message: state.exception.message);
              }
            }
          },
        ),

        /// WorkoutBloc
        BlocListener<WorkoutBloc, WorkoutState>(
          listener: (context, state) {
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

            if (state is WorkoutStateFetchLastDocSnap) {}

            if (state is WorkoutStateFetching ||
                state is WorkoutStateFetchFailure ||
                state is WorkoutStateFetched) {
              setState(() {
                isLoading = state.isLoading;
              });

              if (state is WorkoutStateFetchFailure) {
                debugPrint(state.exception.message);
              }
              if (state is WorkoutStateFetched) {
                for (final workout in state.workouts) {
                  if (!workouts.contains(workout)) {
                    workouts.add(workout);
                  }
                }
                setState(() {});
              }
            }
          },
        ),
      ],
      child: CustomScaffold(
        appBar: customAppBar(
          background: const Color(0xFF2C2C2E).withOpacity(0.62),
          title: "Progression",
        ),
        body: Column(
          children: [
            /// Date View
            CustomWeeklyDate(onSelectedDate: (p0) {
              fetchAllAt(p0);
            }),
            Expanded(
              child: CustomPadding(
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Challenge Title
                    const Text(
                      "Recent Work Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.52,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    gapH20,

                    /// Challenges List
                    Expanded(
                      child: (workouts.isEmpty && !isLoading)
                          ? const Center(
                              child: Text(
                                "No recent workouts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: workouts.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 7),
                              itemBuilder: (context, index) {
                                final workout = workouts[index];
                                return CustomInkWell(
                                  onTap: () {
                                    if (workout is WorkoutModel) {
                                      NavigationService.go(
                                          WorkoutExercisesScreen(
                                              workout: workout));
                                    } else {
                                      context.read<WorkoutBloc>().add(
                                          WorkoutEventGet(
                                              uuid: workout.workoutId));
                                    }
                                  },
                                  child: Container(
                                    height: 193,
                                    margin: const EdgeInsets.only(
                                        top: 7, bottom: 7),
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
                                              imageUrl: workout.coverUrl ?? "",
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
                                                  workout.name,
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
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
