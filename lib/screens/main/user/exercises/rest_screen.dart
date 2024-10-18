// Project: 	   balanced_workout
// File:    	   rest_screen
// Path:    	   lib/screens/main/user/exercises/rest_screen.dart
// Author:       Ali Akbar
// Date:        28-08-24 12:23:14 -- Wednesday
// Description:

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:balanced_workout/models/plan_exercise_model.dart';
import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_container.dart';
import 'package:balanced_workout/screens/components/custom_network_image.dart';
import 'package:balanced_workout/screens/components/custom_scaffold.dart';
import 'package:balanced_workout/utils/constants/constants.dart';
import 'package:balanced_workout/utils/dialogs/rounded_button.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_theme.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({
    super.key,
    required this.nextExercise,
    required this.currentExercise,
    this.restTime = 60,
  });
  final PlanExercise nextExercise;
  final PlanExercise currentExercise;
  final int restTime;
  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  late int seconds = widget.restTime;
  Timer? _timer;
  bool isDualSound = false;

  final AudioPlayer audioPlayer = AudioPlayer();

  void setupAudioPlayer() async {
    audioPlayer.setSourceAsset('sounds/beep.wav');
  }

  void playAudio() async {
    audioPlayer.resume();
    audioPlayer.onPlayerComplete.listen(
      (_) {
        NavigationService.back();
        // if (isDualSound) {
        //   audioPlayer.resume();
        //   isDualSound = false;
        // }
      },
    );
  }

  void checkAdditionalTime() {
    final setOfSets = widget.currentExercise.exercise.sets;
    debugPrint(setOfSets.toString());
  }

  void calculateTime() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (seconds <= 1) {
          playAudio();
          _timer?.cancel();
        }

        setState(() {
          seconds--;
        });
      },
    );
  }

  void increaseTime() {
    _timer?.cancel();
    setState(() {
      seconds += 10;
    });

    if (!(_timer?.isActive ?? true)) {
      calculateTime();
    }
  }

  void decreaseTime() async {
    if (seconds > 10) {
      setState(() {
        seconds -= 10;
      });
    }
  }

  @override
  void initState() {
    calculateTime();
    checkAdditionalTime();
    setupAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    audioPlayer.stop();

    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
          showBack: false,
          titleWidget: const Text(
            "Rest",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 32,
            ),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 30, right: 30, bottom: 50, top: 80),
        child: Column(
          children: [
            Text(
              seconds.formatTime(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 48,
              ),
            ),
            gapH50,
            gapH30,

            /// Next Exercise Widget
            Container(
              width: SCREEN_WIDTH,
              padding: const EdgeInsets.only(
                left: 30,
                right: 20,
                top: 20,
                bottom: 16,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Next Exercise:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH20,
                  Row(
                    children: [
                      CustomContainer(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: CustomNetworkImage(
                          imageUrl: widget.nextExercise.exercise.coverUrl ?? "",
                          width: 80,
                          height: 50,
                        ),
                      ),
                      gapW20,
                      Flexible(
                        child: Text(
                          widget.nextExercise.exercise.name,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.nextExercise.setsValue.isNotEmpty) gapH20,

                  /// Steps
                  if (widget.nextExercise.setsValue.isNotEmpty)
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
                        for (int row = 0;
                            row < widget.nextExercise.exercise.sets.length;
                            row++)
                          DataColumn(
                            label: Text(
                              widget.nextExercise.exercise.sets[row].name
                                  .firstCapitalize(),
                              style: const TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                      rows: [
                        for (int row = 0;
                            row <
                                (widget.nextExercise.setsValue.length > 1
                                    ? 1
                                    : 0);
                            row++)
                          DataRow(
                            cells: [
                              for (int col = 0;
                                  col <
                                      widget.nextExercise.exercise.sets.length;
                                  col++)
                                DataCell(
                                  Text(
                                    "${widget.nextExercise.setsValue[row].isEmpty ? "-" : widget.nextExercise.setsValue[row][col].value ?? "-"} ${widget.nextExercise.setsValue[row][col].value != null ? widget.nextExercise.exercise.sets[col].name.toLowerCase() == "time" ? "s" : widget.nextExercise.exercise.sets[col].name.toLowerCase() == "weights" ? "kg" : "" : ""}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                )
                            ],
                          )
                      ],
                    ),
                  if (widget.nextExercise.exercise.difficulty != null) gapH16,
                  if (widget.nextExercise.exercise.difficulty != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "DIFFICULTY:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.nextExercise.exercise.difficulty
                                  ?.firstCapitalize() ??
                              "",
                          style: const TextStyle(
                            color: AppTheme.titleColor3,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  if (widget.nextExercise.exercise.equipments.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapH20,
                        const Text(
                          "EQUIPMENTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH6,
                        Text(
                          widget.nextExercise.exercise.equipments.join(', '),
                          style: const TextStyle(
                            color: AppTheme.titleColor3,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget
                          .nextExercise.exercise.primaryMuscles.isNotEmpty)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapH20,
                              const Text(
                                "PRIMARY MUSCLES",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              gapH6,
                              Text(
                                widget.nextExercise.exercise.primaryMuscles
                                    .join('\n'),
                                style: const TextStyle(
                                  color: AppTheme.titleColor3,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget
                          .nextExercise.exercise.primaryMuscles.isNotEmpty)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapH20,
                              const Text(
                                "SECONDARY MUSCLES",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              gapH6,
                              Text(
                                widget.nextExercise.exercise.primaryMuscles
                                    .join('\n'),
                                style: const TextStyle(
                                  color: AppTheme.titleColor3,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),

            gapH50,
            gapH20,

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                  width: 50,
                  height: 50,
                  title: "-10",
                  onPressed: () => decreaseTime(),
                ),
                RoundedButton(
                  width: 50,
                  height: 50,
                  title: "Skip Rest",
                  onPressed: () {
                    NavigationService.back();
                  },
                  buttonColor: const Color.fromARGB(255, 54, 54, 54),
                  textColor: Colors.white,
                ),
                RoundedButton(
                  width: 50,
                  height: 50,
                  title: "+10",
                  onPressed: () => increaseTime(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
