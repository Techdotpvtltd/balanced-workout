// Project: 	   balanced_workout
// File:    	   home_screen
// Path:    	   lib/screens/main/user/home_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 13:09:09 -- Monday
// Description:

import 'package:balanced_workout/screens/main/user/activity_level_screen.dart';
import 'package:balanced_workout/screens/main/user/challenges/challenge_exercises_screen.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../app/app_manager.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/avatar_widget.dart';
import '../../components/chat_widget.dart';
import '../../components/circle_button.dart';
import '../../components/custom_ink_well.dart';
import 'article_screen.dart';
import 'community/community_screen.dart';
import 'components/article_items.dart';
import 'components/horizontal_product_card.dart';
import 'components/navigation_button.dart';
import 'notification_screen.dart';
import 'settings/edit_profile_screen.dart';

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
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomInkWell(
                  onTap: () {
                    NavigationService.go(const EditProfileScreen());
                  },
                  child: AvatarWidget(
                    avatarUrl: AppManager().user.avatar,
                    width: 52,
                    height: 52,
                    backgroundColor: Colors.black,
                    placeholderChar:
                        AppManager().user.name.characters.firstOrNull,
                  ),
                ),
              ),
            ),
            titleSpacing: 8,

            /// Tite Widget
            title: Text.rich(
              TextSpan(
                text: "Hi, ",
                children: [
                  TextSpan(
                    text: AppManager().user.name,
                    style: const TextStyle(
                      color: AppTheme.primaryColor1,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: false,

            /// Action Widget
            actions: [
              gapW10,
              CircleButton(
                icon: AppAssets.bellIcon,
                onPressed: () {
                  NavigationService.go(const NotificationScreen());
                },
              ),
              gapW30,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today Activity",
                          style: TextStyle(
                            fontSize: 22,
                            color: AppTheme.primaryColor1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          DateTime.now()
                              .dateToString('yyyy MMMM dd')
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    /// Circle Widget
                    const SizedBox(
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
                      isSVG: true,
                      onPressed: () {
                        NavigationService.go(
                          ActivityLevelScreen(type: ScreenType.workout),
                        );
                      },
                    ),
                  ),
                  gapW10,
                  Expanded(
                    child: NavigationButton(
                      title: "Challenges",
                      icon: AppAssets.challengeIcon,
                      isSVG: true,
                      onPressed: () {
                        NavigationService.go(const ChallengeExerciseScreen());
                      },
                    ),
                  ),
                ],
              ),
              gapH26,

              /// Recent Challenges
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Challenges",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.go(const ChallengeExerciseScreen());
                    },
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              gapH14,
              SizedBox(
                height: 160,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 7),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: HorizontalProductCard(
                          coverUrl:
                              'https://www.bodybuilding.com/images/2016/july/build-your-best-chest-5-must-do-pec-exercises-header-v2-960x540.jpg',
                          timePeriod: '4 Weeks',
                          title: 'Full Body stretching',
                          celeries: '130 Kcal',
                          onClick: () {
                            NavigationService.go(
                                const ChallengeExerciseScreen());
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              gapH24,
              // ===========================Communities================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Communites",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.go(const CommunityScreen());
                    },
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              gapH14,
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 7),
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ChatWidget(),
                  );
                },
              ),

              // ===========================Science and Facts Section================================
              gapH24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Science and Facts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.go(const ArticleScreen());
                    },
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              gapH14,
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 7),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: SCREEN_WIDTH * 0.8,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: ArticleItem(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
