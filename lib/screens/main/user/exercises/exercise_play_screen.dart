// Project: 	   balanced_workout
// File:    	   exercise_play_screen
// Path:    	   lib/screens/main/user/exercises/exercise_play_screen.dart
// Author:       Ali Akbar
// Date:        09-07-24 16:23:55 -- Tuesday
// Description:

import 'dart:async';

import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_button.dart';
import 'package:balanced_workout/utils/constants/app_theme.dart';
import 'package:balanced_workout/utils/constants/constants.dart';
import 'package:balanced_workout/utils/extensions/int_ext.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExercisePlayScreen extends StatefulWidget {
  const ExercisePlayScreen({super.key});

  @override
  State<ExercisePlayScreen> createState() => _ExercisePlayScreenState();
}

class _ExercisePlayScreenState extends State<ExercisePlayScreen> {
  int seconds = 0;
  Timer? _timer;
  ChewieController? chewieController;
  bool isPlaying = false;
  void prepareVideoController() async {
    final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
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

    chewieController?.videoPlayerController.addListener(
      () {
        setState(() {
          isPlaying = chewieController?.isPlaying ?? true;
        });
      },
    );
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
          title: "Complete Exercise",
          onlyBorder: true,
          onPressed: () {},
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
            child: chewieController != null
                ? Chewie(
                    controller: chewieController!,
                  )
                : const SizedBox(),
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
                    left: 29, right: 10, top: 20, bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Basic Info
                    const Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Push up",
                            style: TextStyle(
                              color: AppTheme.titleColor2,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "3 Reps",
                            style: TextStyle(
                              color: AppTheme.titleColor1,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Equipments
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapH20,
                        Text(
                          "EQUIPMENTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH6,
                        Text(
                          "Dumbbell, Dumbell",
                          style: TextStyle(
                            color: AppTheme.titleColor3,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    /// Steps Column
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
                        for (int i = 0; i < 4; i++)
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
                                const Flexible(
                                  child: Text(
                                    "Reloaded 1 of 2365 libraries in 301ms (compile: 27 ms, reload: 116 ms, reassemble: 146 ms).",
                                    style: TextStyle(
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapH20,
                        Text(
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
                            Text(
                              "Primary Muscle",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            gapH6,
                            Text(
                              "Triceps, Biceps",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            gapH6,
                          ],
                        ),

                        /// Secondary Muscle
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Secondary Muscle",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            gapH6,
                            Text(
                              "Triceps, Biceps",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            gapH6,
                          ],
                        ),

                        /// Note
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gapH10,
                            Text(
                              "Note",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            gapH6,
                            Text(
                              "Reloaded 1 of 2365 libraries in 379msReloaded 1 of 2365 libraries in 379msReloaded 1 of 2365 libraries in 379ms",
                              style: TextStyle(
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
