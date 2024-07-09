// Project: 	   balanced_workout
// File:    	   startup_challenge_screen
// Path:    	   lib/screens/main/user/startup_challenge_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 19:13:41 -- Monday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_network_image.dart';
import '../../components/custom_paddings.dart';

// FIXME: Check for usages
class StartupChallengeScreen extends StatelessWidget {
  const StartupChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: CustomNetworkImage(
            imageUrl:
                "https://qph.cf2.quoracdn.net/main-qimg-7f7a3df018535dccbb184647950ebca3-lq",
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: customAppBar(),
            body: SizedBox(
              height: SCREEN_HEIGHT * 0.7,
              width: SCREEN_WIDTH,
              child: HorizontalPadding(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 265,
                    child: Stack(
                      children: [
                        Container(
                          height: 235,
                          padding: const EdgeInsets.only(
                              top: 18, left: 40, right: 40),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor1,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(AppAssets.runnerBlackBackground),
                              gapH8,
                              const Text(
                                "7x4 Challenge",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.titleDarkColor1,
                                ),
                              ),
                              gapH8,
                              const Flexible(
                                child: Text(
                                  "Lorem ipsum is Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface.",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.titleDarkColor1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton(
                              onPressed: () {
                                // NavigationService.go(
                                //     const ProgressCourseScreen());
                              },
                              width: 217,
                              title: "Start Now",
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
