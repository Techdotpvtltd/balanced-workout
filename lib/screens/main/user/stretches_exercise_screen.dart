// Project: 	   balanced_workout
// File:    	   stretches_exercise_screen
// Path:    	   lib/screens/main/user/stretches_exercise_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 20:09:19 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import 'activity_level_screen.dart';
import 'components/custom_tab_bar.dart';
import 'components/product_card.dart';
import 'progress_challenge_screen.dart';

class StretchesExerciseScreen extends StatelessWidget {
  const StretchesExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Stretches",
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
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      width: SCREEN_WIDTH * 0.8,
                      child: ProductCard(
                        title: "Post Run Stretches Exercise",
                        coverUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyO3iX9o0_FKLto80XtEdT7B6w0gcEqWwWecuXuTi6Tg&s",
                        onClickCard: () {
                          NavigationService.go(const ProgressChallengeScreen());
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
                          title: "Best Lower Back Stretches",
                          coverUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpwoD5IrYGtsyzeRC3aUSODK8n2x7WO8f-KUHh52UbItJSg8mMpr-UnUe_IQYRIEfuVeQ&usqp=CAU",
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
