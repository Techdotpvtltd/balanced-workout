// Project: 	   balanced_workout
// File:    	   weekly_plan_screen
// Path:    	   lib/screens/main/user/weekly_plan_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 19:11:10 -- Tuesday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import 'components/custom_tab_bar.dart';
import 'components/product_card.dart';
import 'progress_challenge_screen.dart';
import 'startup_challenge_screen.dart';

class WeeklyPlanScreen extends StatelessWidget {
  const WeeklyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Weekly Plans"),
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
                        title: "Healthy Weight Loss",
                        coverUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMkj6sxP6kJP0QbBiL1u3YLodQqH4fu8waUO-ct1jVlw&s",
                        subTitle: '7 Week',
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
                  for (int index = 0; index < 2; index++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SizedBox(
                        height: 198,
                        child: ProductCard(
                          title: "Healthy Weight Loss",
                          coverUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTICKQ3S3s4bgieQWmrm_uSghB-afk1LAJLbP2Ot2bikXTgM1JMNCg2rX88pKxVQmT1rCg&usqp=CAU",
                          subTitle: '7 Week',
                          onClickStartButton: () {
                            NavigationService.go(
                                const StartupChallengeScreen());
                          },
                          onClickCard: () {
                            NavigationService.go(
                                const StartupChallengeScreen());
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
