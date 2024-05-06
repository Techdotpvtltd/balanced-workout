// Project: 	   balanced_workout
// File:    	   home_screen
// Path:    	   lib/screens/main/user/home_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 13:09:09 -- Monday
// Description:

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/avatar_widget.dart';
import '../../components/circle_button.dart';
import 'challenge_screen.dart';
import 'components/navigation_button.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leadingWidth: SCREEN_WIDTH * 0.28,
            toolbarHeight: SCREEN_HEIGHT,
            leading: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppTheme.darkButtonColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(167),
                    bottomRight: Radius.circular(167)),
              ),

              /// Avatar Widget
              child: const Align(
                alignment: Alignment.centerRight,
                child: AvatarWidget(
                  avatarUrl: "",
                  width: 52,
                  height: 52,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            titleSpacing: 8,

            /// Tite Widget
            title: const Text.rich(
              TextSpan(
                text: "Hi, ",
                children: [
                  TextSpan(
                    text: "Akbar",
                    style: TextStyle(
                      color: AppTheme.primaryColor1,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: false,

            /// Action Widget
            actions: [
              CircleButton(
                icon: AppAssets.magnifierIcon,
                onPressed: () {},
              ),
              gapW10,
              CircleButton(
                icon: AppAssets.bellIcon,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),

      /// Contents
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 29, right: 29, top: 35, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Progress Status Container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                decoration: const BoxDecoration(
                  color: AppTheme.darkWidgetColor,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today Activity",
                          style: TextStyle(
                            fontSize: 22,
                            color: AppTheme.primaryColor1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "2024 October 25",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    /// Circle Widget
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: PieChart(
                        dataMap: {"App": 34},
                        chartType: ChartType.ring,
                        baseChartColor: AppTheme.darkButtonColor,
                        initialAngleInDegree: 270,
                        colorList: [AppTheme.primaryColor1],
                        totalValue: 100,
                        chartLegendSpacing: 0,
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: false,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                        ),
                        legendOptions: LegendOptions(
                          showLegends: false,
                          showLegendsInRow: false,
                        ),
                        ringStrokeWidth: 16,
                      ),
                    ),
                  ],
                ),
              ),
              gapH32,

              /// NavigationButton
              Row(
                children: [
                  Expanded(
                    child: NavigationButton(
                      title: "Active Workout",
                      icon: AppAssets.workoutIcon,
                      onPressed: () {},
                    ),
                  ),
                  gapW10,
                  Expanded(
                    child: NavigationButton(
                      title: "Challenges",
                      icon: AppAssets.challengeIcon,
                      onPressed: () {
                        NavigationService.go(const ChallengeScreen());
                      },
                    ),
                  ),
                ],
              ),
              gapH26,

              /// Recent Challenges
              const Text(
                "Recent Challenges",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              gapH14,
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 7),
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: "Simply Chest Work",
                    subTitle: "7x4 Challenge",
                    onClickStartButton: () {},
                    coverUrl:
                        'https://sunnyhealthfitness.com/cdn/shop/articles/15-Minute-Full-Body-Workout-No-Equipment-01.jpg?v=1593542919',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
