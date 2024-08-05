// Project: 	   balanced_workout
// File:    	   exercise_play_screen
// Path:    	   lib/screens/main/user/exercises/exercise_play_screen.dart
// Author:       Ali Akbar
// Date:        09-07-24 16:23:55 -- Tuesday
// Description:

import 'dart:async';

import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_button.dart';
import 'package:balanced_workout/screens/components/custom_network_image.dart';
import 'package:balanced_workout/utils/constants/app_theme.dart';
import 'package:balanced_workout/utils/constants/constants.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../models/plan_exercise_model.dart';

class ExercisePlayScreen extends StatefulWidget {
  const ExercisePlayScreen(
      {super.key, required this.planExercises, this.currentExercise});
  final List<PlanExercise> planExercises;
  final PlanExercise? currentExercise;
  @override
  State<ExercisePlayScreen> createState() => _ExercisePlayScreenState();
}

class _ExercisePlayScreenState extends State<ExercisePlayScreen> {
  late PlanExercise currentExercise =
      widget.currentExercise ?? widget.planExercises.first;
  late List<PlanExercise> planExercises = List.from(widget.planExercises);

  int seconds = 0;
  Timer? _timer;
  ChewieController? chewieController;
  bool isPlaying = false;

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
    }
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
          title: "Next Exercise",
          onPressed: () {
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
                    imageUrl: currentExercise.exercise.coverUrl ?? "",
                  ),
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
                        gapH20,

                        /// Durations
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "DURATION",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            gapH6,
                            Text(
                              currentExercise.exercise.duration.formatTime(),
                              style: const TextStyle(
                                color: AppTheme.titleColor1,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        if (currentExercise.setsValue.isNotEmpty) gapH20,
                        if (currentExercise.setsValue.isNotEmpty)
                          DataTable(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.titleColor1,
                                width: 0.1,
                              ),
                            ),
                            dividerThickness: 0.2,
                            headingTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            dataTextStyle: const TextStyle(
                              color: AppTheme.titleColor1,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            columns: [
                              const DataColumn(label: Text("Set")),
                              for (int row = 0;
                                  row < currentExercise.exercise.sets.length;
                                  row++)
                                DataColumn(
                                  label: Text(
                                    currentExercise.exercise.sets[row].name
                                        .firstCapitalize(),
                                  ),
                                ),
                            ],
                            rows: [
                              for (int row = 0;
                                  row < currentExercise.setsValue.length;
                                  row++)
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        "${row + 1}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    for (int col = 0;
                                        col <
                                            currentExercise
                                                .exercise.sets.length;
                                        col++)
                                      DataCell(
                                        Text(
                                          "${currentExercise.setsValue[row].isEmpty ? "-" : currentExercise.setsValue[row][col].value ?? "-"} ${currentExercise.setsValue[row][col].value != null ? currentExercise.exercise.sets[col].name.toLowerCase() == "time" ? "s" : currentExercise.exercise.sets[col].name.toLowerCase() == "weights" ? "kg" : "" : ""}",
                                        ),
                                      )
                                  ],
                                )
                            ],
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
                            "STEPS",
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
