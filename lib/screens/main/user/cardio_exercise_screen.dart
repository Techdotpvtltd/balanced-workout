// Project: 	   balanced_workout
// File:    	   cardio_exercise_screen
// Path:    	   lib/screens/main/user/cardio_exercise_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 20:03:28 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import 'activity_level_screen.dart';
import 'components/custom_tab_bar.dart';
import 'components/product_card.dart';
import 'playlist_screen.dart';

class CardioExerciseScreen extends StatelessWidget {
  const CardioExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Cardio Exercise",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomPadding(
              bottom: 22,

              /// Active Title
              child: Text(
                "Active",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            /// Active List View
            SizedBox(
              height: SCREEN_HEIGHT * 0.23,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      width: SCREEN_WIDTH * 0.8,
                      child: ProductCard(
                        title: "Healthy Weight Loss & Heart Health",
                        coverUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQOrqAgZ6xitFSpc6Kpx-JtHC5QA6tIYyrgFhMIvPhgg&s",
                        onClickCard: () {
                          NavigationService.go(const PlaylistScreen());
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            gapH34,

            /// Custom Tab Bar
            HorizontalPadding(
              child: Column(
                children: [
                  CustomTabBar(
                    items: const ['All', 'Completed'],
                    onPressed: (index) {},
                  ),
                  gapH20,
                  for (int index = 0; index < 3; index++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SizedBox(
                        height: 198,
                        child: ProductCard(
                          title: "Heart Health Exercise",
                          coverUrl:
                              "https://www.nourishmovelove.com/wp-content/uploads/2021/11/Low-Impact-Workout-2.jpg",
                          onClickStartButton: () {
                            NavigationService.go(ActivityLevelScreen());
                          },
                          onClickCard: () {
                            NavigationService.go(ActivityLevelScreen());
                          },
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
