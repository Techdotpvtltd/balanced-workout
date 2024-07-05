// Project: 	   balanced_workout
// File:    	   cardio_exercise_screen
// Path:    	   lib/screens/main/user/cardio_exercise_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 20:03:28 -- Tuesday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app_manager.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import '../content_detail_screen.dart';

class CardioExerciseScreen extends StatefulWidget {
  const CardioExerciseScreen({super.key});

  @override
  State<CardioExerciseScreen> createState() => _CardioExerciseScreenState();
}

class _CardioExerciseScreenState extends State<CardioExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                /// Color Blur Widget
                child: SizedBox(
                  height: SCREEN_HEIGHT * 0.3,
                  width: SCREEN_WIDTH,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.srcOver),

                    /// Background Image
                    child: const CustomNetworkImage(
                      imageUrl:
                          "https://img.freepik.com/premium-photo/portrait-happy-man-exercising-elliptical-machine_107420-30404.jpg?size=626&ext=jpg",
                    ),
                  ),
                ),
              ),

              /// Custom App Bar
              customAppBar(
                title: AppManager().screenTitle,
              ),
            ],
          ),

          /// Contents
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 30, left: 29, right: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Details
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30,
                    ),
                    decoration: const BoxDecoration(
                      color: AppTheme.darkWidgetColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Column(
                      children: [
                        /// Difficulty Level
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 24,
                            ),
                            gapW10,
                            Text(
                              "Difficulty",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Medium",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        gapH10,

                        /// Exercises Number
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.numbers,
                              color: Colors.grey,
                              size: 24,
                            ),
                            gapW10,
                            Text(
                              "Exercises",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "12",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        gapH10,

                        /// Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                              size: 24,
                            ),
                            gapW10,
                            Text(
                              "Time",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "3 hours",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  gapH20,
                  const Text(
                    "Exercises",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  gapH14,

                  /// Play List Widget
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 12,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomInkWell(
                        onTap: () {
                          NavigationService.go(const ContentDetailScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: const BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.all(Radius.circular(36)),
                          ),
                          child: Row(
                            children: [
                              /// Play Button
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor1,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                              gapW16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Exercise",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    /// Time Zone View
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.clockIcon),
                                        gapW8,
                                        const Text(
                                          "10:30",
                                          style: TextStyle(
                                            color: Color(0xFF8C8C8C),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
