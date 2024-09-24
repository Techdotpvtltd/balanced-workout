// Project: 	   balanced_workout
// File:    	   workout_play_exercises_screen
// Path:    	   lib/screens/main/user/workouts/workout_play_exercises_screen.dart
// Author:       Ali Akbar
// Date:        24-09-24 18:11:02 -- Tuesday
// Description:

import 'dart:async';

import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/models/workout_round_model.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../app/app_manager.dart';
import '../../../../blocs/log/log_event.dart';
import '../../../../models/logs/exercise_log_model.dart';
import '../../../../models/plan_exercise_model.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_network_image.dart';
import '../exercises/rest_screen.dart';

class WorkoutPlayExercisesScreen extends StatefulWidget {
  const WorkoutPlayExercisesScreen(
      {super.key,
      required this.planExercises,
      this.currentExercise,
      this.onRoundCompleted,
      required this.round});
  final List<PlanExercise> planExercises;
  final PlanExercise? currentExercise;
  final VoidCallback? onRoundCompleted;
  final WorkoutRoundModel round;
  @override
  State<WorkoutPlayExercisesScreen> createState() =>
      _WorkoutPlayExercisesScreenState();
}

class _WorkoutPlayExercisesScreenState
    extends State<WorkoutPlayExercisesScreen> {
  late PlanExercise currentExercise =
      widget.currentExercise ?? widget.planExercises.first;
  late List<PlanExercise> planExercises = List.from(widget.planExercises);
  PlanExercise? nextExercise;
  int currentSet = 1;
  int seconds = 0;
  Timer? _timer;
  ChewieController? chewieController;
  bool isPlaying = false;
  bool isRoundCompleted = false;

  void triggerSaveExerciseLogEvent() {
    final List<String> muscles =
        List.from(currentExercise.exercise.primaryMuscles);
    muscles.addAll(currentExercise.exercise.secondaryMuscles);
    muscles.toSet().toList();

    final exer = ExerciseLogModel(
        uuid: "",
        exerciseId: currentExercise.exercise.uuid,
        userId: AppManager().user.uid,
        title: currentExercise.exercise.name,
        coverUrl: currentExercise.exercise.coverUrl ?? "",
        startDate: DateTime.now(),
        muscles: muscles
            .map((e) => ExerciseMuscleType.values
                .firstWhere((m) => m.name.toLowerCase() == e.toLowerCase()))
            .toList(),
        type: PlanType.workout);
    context.read<LogBloc>().add(LogEventSaveExercise(exercise: exer));
  }

  void getNextExercise() {
    final int nextExerIndex =
        planExercises.indexWhere((e) => e.uuid == currentExercise.uuid) + 1;
    if (nextExerIndex < planExercises.length) {
      nextExercise = planExercises[nextExerIndex];
    } else {
      nextExercise = null;
    }

    debugPrint(nextExercise.toString());
  }

  void processNextExercise() {
    final int nextIndex =
        planExercises.indexWhere((e) => e.uuid == currentExercise.uuid) + 1;
    if (nextIndex < planExercises.length) {
      setState(() {
        setState(() {
          chewieController?.dispose();
          chewieController?.videoPlayerController.dispose();
          chewieController = null;
        });
        currentExercise = planExercises[nextIndex];
      });

      prepareVideoController();
      triggerSaveExerciseLogEvent();
      getNextExercise();
    } else {
      checkRemainingSets();
    }
  }

  void checkRemainingSets() async {
    if (currentSet < widget.round.noOfSets) {
      currentSet++;
      currentExercise = planExercises.first;
      getNextExercise();
      await NavigationService.present(RestScreen(
        currentExercise: currentExercise,
        nextExercise: currentExercise,
        restTime: widget.round.rest,
      ));
    } else {
      isRoundCompleted = currentSet >= widget.round.noOfSets;
    }

    setState(() {});
  }

  void prepareVideoController() async {
    if (currentExercise.exercise.video == null) {
      return;
    }

    final videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(currentExercise.exercise.video!.url),
    );
    await videoPlayerController.initialize();
    setState(() {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        looping: true,
        showOptions: false,
        aspectRatio: 1.5,
      );
    });
  }

  void executeTime() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          seconds = _.tick;
        });
      },
    );
  }

  @override
  void initState() {
    executeTime();
    prepareVideoController();
    triggerSaveExerciseLogEvent();
    getNextExercise();

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    chewieController?.videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: CustomButton(
          title: (nextExercise == null && !isRoundCompleted)
              ? "Complete Set $currentSet"
              : (isRoundCompleted
                  ? "Mark Round ${widget.round.id + 1} Completed"
                  : "Next Exercise (Set $currentSet)"),
          subTitle: nextExercise?.exercise.name,
          onPressed: () async {
            if (isRoundCompleted) {
              NavigationService.back();
              widget.onRoundCompleted!();
              return;
            }
            processNextExercise();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: customAppBar(
        centerTitle: true,
        titleWidget: Text(
          seconds.formatTime(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
        ),
        actions: [
          Text(
            "Set $currentSet",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          gapW20,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Video Player Widget
          Container(
            margin: const EdgeInsets.only(top: 30, right: 29, left: 29),
            width: SCREEN_WIDTH,
            height: 250,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: AppTheme.darkWidgetColor2,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: currentExercise.exercise.video != null
                ? chewieController != null
                    ? Chewie(
                        controller: chewieController!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
                : CustomNetworkImage(
                    imageUrl: currentExercise.exercise.coverUrl ?? ""),
          ),

          gapH20,
          Expanded(
            child: Container(
              width: SCREEN_WIDTH,
              decoration: const BoxDecoration(
                color: AppTheme.darkWidgetColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 29,
                  right: 10,
                  top: 20,
                  bottom: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Basic Info

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            currentExercise.exercise.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppTheme.titleColor2,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Equipments
                    if (currentExercise.exercise.equipments.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapH20,
                          const Text(
                            "EQUIPMENTS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapH6,
                          Text(
                            currentExercise.exercise.equipments.join(', '),
                            style: const TextStyle(
                              color: AppTheme.titleColor3,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                    /// Steps Column
                    if (currentExercise.exercise.steps.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapH20,
                          const Text(
                            "STEPS:  HOW TO",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapH6,
                          for (int i = 0;
                              i < currentExercise.exercise.steps.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${i + 1}.  ",
                                    style: const TextStyle(
                                      color: AppTheme.titleColor1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      currentExercise.exercise.steps[i],
                                      style: const TextStyle(
                                        color: AppTheme.titleColor1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                    gapH20,

                    /// PrimaryFocus
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapH20,
                        const Text(
                          "PRIMARY FOCUS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH8,

                        /// Primary Muscle
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Primary Muscle",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            gapH6,
                            Text(
                              currentExercise.exercise.primaryMuscles
                                  .join(', '),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            gapH6,
                          ],
                        ),

                        /// Secondary Muscle
                        if (currentExercise
                            .exercise.secondaryMuscles.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Secondary Muscle",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              gapH6,
                              Text(
                                currentExercise.exercise.primaryMuscles
                                    .join(', '),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              gapH6,
                            ],
                          ),

                        /// Secondary Muscle
                        if (currentExercise.exercise.modality.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Modality",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              gapH6,
                              Text(
                                currentExercise.exercise.modality
                                    .firstCapitalize(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              gapH6,
                            ],
                          ),

                        /// Difficulty
                        if (currentExercise.exercise.difficulty != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Difficulty",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              gapH6,
                              Text(
                                currentExercise.exercise.difficulty
                                        ?.firstCapitalize() ??
                                    "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              gapH6,
                            ],
                          ),

                        /// Note
                        if (currentExercise.exercise.note != "")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapH10,
                              const Text(
                                "Note",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              gapH6,
                              Text(
                                currentExercise.exercise.note ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              gapH6,
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
