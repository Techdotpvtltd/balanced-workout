// Project: 	   balanced_workout
// File:    	   home_screen
// Path:    	   lib/screens/main/user/home_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 13:09:09 -- Monday
// Description:

import 'package:balanced_workout/app/cache_manager.dart';
import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/blocs/log/log_state.dart';
import 'package:balanced_workout/models/article_model.dart';
import 'package:balanced_workout/models/logs/exercise_log_model.dart';
import 'package:balanced_workout/screens/main/user/activity_level_screen.dart';
import 'package:balanced_workout/screens/main/user/challenges/challenge_exercises_screen.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../app/app_manager.dart';
import '../../../blocs/article/article_bloc.dart';
import '../../../blocs/article/article_event.dart';
import '../../../blocs/article/article_state.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExerciseLogModel> logChallenges = [];

  late List<ArticleModel> articles =
      context.read<ArticleBloc>().articles.take(5).toList();

  void triggerFetchArticlesEvent() {
    context.read<ArticleBloc>().add(ArticleEventFetch());
  }

  void triggerFetchAllWorkoutsLogEvent() {
    context.read<LogBloc>().add(LogEventFetchAllWorkouts());
  }

  void triggerFetchAllExercisesLogEvent() {
    context.read<LogBloc>().add(LogEventFetchExercises());
  }

  @override
  void initState() {
    triggerFetchArticlesEvent();
    triggerFetchAllWorkoutsLogEvent();
    triggerFetchAllExercisesLogEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// Log Bloc
        BlocListener<LogBloc, LogState>(
          listener: (_, state) {
            if (state is LogStateFetchedExercises ||
                state is LogStateSavedExercise) {
              setState(() {
                logChallenges = CacheLogExercise()
                    .findBy(PlanType.challenge)
                    .take(5)
                    .toList();
              });
            }
          },
        ),

        /// ArticleBloc
        BlocListener<ArticleBloc, ArticleState>(listener: (context, state) {
          if (state is ArticleStateFetched ||
              state is ArticleStateFetching ||
              state is ArticleStateFetchFailure) {
            if (state is ArticleStateFetched) {
              setState(() {
                articles =
                    context.read<ArticleBloc>().articles.take(5).toList();
              });
            }
          }
        })
      ],
      child: Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: const BoxDecoration(
                  color: AppTheme.darkButtonColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(167),
                    bottomRight: Radius.circular(167),
                  ),
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
                            ActivityLevelScreen(
                              type: ScreenType.workout,
                              isShowLogs: true,
                            ),
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
                if (logChallenges.isNotEmpty)
                  Column(
                    children: [
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
                              NavigationService.go(
                                  const ChallengeExerciseScreen());
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
                          itemCount: logChallenges.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(bottom: 7),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: HorizontalProductCard(
                                  coverUrl: logChallenges[index].coverUrl,
                                  title: logChallenges[index].title,
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
                    ],
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
                if (articles.isNotEmpty)
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
                if (articles.isNotEmpty) gapH14,
                if (articles.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: articles.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 7),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: SCREEN_WIDTH * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ArticleItem(article: articles[index]),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
