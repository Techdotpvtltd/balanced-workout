// Project: 	   balanced_workout
// File:    	   challenge_screen
// Path:    	   lib/screens/main/user/challenge_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 18:12:53 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_paddings.dart';
import 'components/horizontal_product_card.dart';
import 'components/product_card.dart';
import 'progress_challenge_screen.dart';
import 'startup_challenge_screen.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Challenges",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 34, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Horizontal List Title
            const HorizontalPadding(
              child: Text(
                "Active Challenges",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.52,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            gapH20,

            /// Horizontal List
            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: 4,
                padding: const EdgeInsets.only(left: 29, right: 29),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HorizontalProductCard(
                    coverUrl:
                        'https://www.bodybuilding.com/images/2016/july/build-your-best-chest-5-must-do-pec-exercises-header-v2-960x540.jpg',
                    timePeriod: '4 Weeks',
                    title: 'Full Body stretching',
                    celeries: '130 Kcal',
                    onClick: () {
                      NavigationService.go(const ProgressChallengeScreen());
                    },
                  );
                },
              ),
            ),
            gapH26,

            HorizontalPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Challenge Title
                  const Text(
                    "Challenges",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.52,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  gapH20,

                  /// Challenges List
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 7),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        title: "Simply Chest Work",
                        subTitle: "7x4 Challenge",
                        onClickCard: () {
                          NavigationService.go(const StartupChallengeScreen());
                        },
                        onClickStartButton: () {
                          NavigationService.go(const StartupChallengeScreen());
                        },
                        coverUrl:
                            'https://allmaxnutrition.com/cdn/shop/articles/13576-1200x600-1.jpg?v=1678816564',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
