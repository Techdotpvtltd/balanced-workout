// Project: 	   balanced_workout
// File:    	   workout_screen
// Path:    	   lib/screens/main/user/workout/workout_screen.dart
// Author:       Ali Akbar
// Date:        31-07-24 19:42:07 -- Wednesday
// Description:

import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/blocs/log/log_state.dart';
import 'package:balanced_workout/models/workout_model.dart';
import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_paddings.dart';
import 'package:balanced_workout/screens/components/custom_scaffold.dart';
import 'package:balanced_workout/screens/main/user/workouts/workout_exercises_screen.dart';
import 'package:balanced_workout/utils/dialogs/dialogs.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../blocs/workout/workout_bloc.dart';
import '../../../../blocs/workout/workout_event.dart';
import '../../../../blocs/workout/workout_state.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/enum.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen(
      {super.key, required this.selectedLevel, required this.isShowLogs});
  final Level selectedLevel;
  final bool isShowLogs;
  @override
  State<WorkoutListScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutListScreen> {
  late Level selectedLevel = widget.selectedLevel;
  bool isLoading = false;
  List<dynamic> workouts = [];

  DocumentSnapshot? lastDocSnap;
  bool isReachedEnd = false;

  final ScrollController scrollController = ScrollController();

  void addScrollListener() {
    scrollController.addListener(
      () {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (!isReachedEnd) triggerFetchWorkoutEvent();
        }
      },
    );
  }

  void triggerFetchLogsWorkoutEvent() {
    context
        .read<LogBloc>()
        .add(LogEventFetchWorkoutsByLevel(level: widget.selectedLevel));
  }

  void triggerFetchWorkoutEvent() {
    context.read<WorkoutBloc>().add(
          WorkoutEventFetch(
            forLevel: selectedLevel,
            lastSnapDoc: lastDocSnap,
          ),
        );
  }

  @override
  void initState() {
    if (widget.isShowLogs) {
      triggerFetchLogsWorkoutEvent();
    } else {
      triggerFetchWorkoutEvent();
      addScrollListener();
    }
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
            if (state is WorkoutStateFetchLastDocSnap) {
              isReachedEnd = state.lasSnapDoc == null;
              lastDocSnap = state.lasSnapDoc;
            }

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
        appBar: customAppBar(title: "Workouts"),
        body: CustomPadding(
          top: 6,
          child: Skeletonizer(
            enabled: isLoading && lastDocSnap == null,
            child: (workouts.isEmpty && !isLoading)
                ? const Center(
                    child: Text(
                      "No workouts available",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: workouts.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (_, index) {
                      final workout = workouts[index];
                      return CustomInkWell(
                        onTap: () {
                          if (workout is WorkoutModel) {
                            NavigationService.go(
                                WorkoutExercisesScreen(workout: workout));
                          } else {}
                        },
                        child: Container(
                          height: 193,
                          margin: const EdgeInsets.only(top: 7, bottom: 7),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: AppTheme.darkWidgetColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      const Color(0xff000000).withOpacity(0.35),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }
}
