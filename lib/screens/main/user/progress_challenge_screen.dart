// Project: 	   balanced_workout
// File:    	   progress_challenge_screen
// Path:    	   lib/screens/main/user/progress_challenge_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 12:14:56 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_paddings.dart';

class ProgressChallengeScreen extends StatefulWidget {
  const ProgressChallengeScreen({super.key});

  @override
  State<ProgressChallengeScreen> createState() =>
      _ProgressChallengeScreenState();
}

class _ProgressChallengeScreenState extends State<ProgressChallengeScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(0.3);
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            height: SCREEN_HEIGHT * 0.3,
            width: SCREEN_WIDTH,
            child: Stack(
              children: [
                Positioned.fill(
                  /// Color Blur Widget
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.srcOver),

                    /// Background Image
                    child: const CustomNetworkImage(
                      imageUrl:
                          "https://indianutrition.com/wp-content/uploads/2020/03/core-strength-fitness.jpg",
                    ),
                  ),
                ),

                /// Progress Show Widget
                Positioned.fill(
                  child: CustomPadding(
                    bottom: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "27 days left",
                              style: TextStyle(
                                color: AppTheme.primaryColor1,
                                fontFamily: 'SfProDisplay',
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              "${(controller.value * 100).ceil()}%",
                              style: const TextStyle(
                                color: AppTheme.primaryColor1,
                                fontFamily: 'SfProDisplay',
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ],
                        ),
                        gapH6,

                        /// Progress Indicator
                        LinearProgressIndicator(
                          value: controller.value,
                          color: Colors.white,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          minHeight: 6,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: customAppBar(
              title: "Active Workout",
              appBarSize: 60,
            ),
          ),
        ),
      ],
    );
  }
}
