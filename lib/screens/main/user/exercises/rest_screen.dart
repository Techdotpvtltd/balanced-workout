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
import 'package:flutter/material.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({
    super.key,
    required this.nextExercise,
    required this.currentExercise,
  });
  final PlanExercise nextExercise;
  final PlanExercise currentExercise;

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  int seconds = 59;
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
