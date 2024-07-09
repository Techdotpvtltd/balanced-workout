// Project: 	   balanced_workout
// File:    	   progress_course_screen
// Path:    	   lib/screens/main/user/progress_course_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 12:14:56 -- Tuesday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_paddings.dart';
import '../playlist_screen.dart';

class ProgressCourseScreen extends StatefulWidget {
  const ProgressCourseScreen({super.key});

  @override
  State<ProgressCourseScreen> createState() => _ProgressCourseScreenState();
}

class _ProgressCourseScreenState extends State<ProgressCourseScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(0.5);
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
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

                    /// Custom App Bar
                    Positioned(
                      child: customAppBar(title: "Course"),
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
          ),

          /// Content
          Positioned(
            top: SCREEN_HEIGHT - ((SCREEN_HEIGHT * 70) / 100),
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 40),
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  color: const Color(0xFFCAC9CF),
                  indicatorPosition: 0,
                  nodePosition: 0.5,
                ),
                builder: TimelineTileBuilder.connected(
                  contentsAlign: ContentsAlign.basic,
                  connectionDirection: ConnectionDirection.before,
                  nodePositionBuilder: (context, index) => 0,
                  itemCount: 4,
                  contentsBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: _ContentWidget(
                        title: 'Week ${index + 1}',
                        completedDays: index == 0
                            ? [0, 1, 2, 3, 4, 5, 6]
                            : index == 1
                                ? [0, 1, 2, 6]
                                : [],
                        weekNumber: index,
                        onPressedDay: (week, day) {
                          NavigationService.go(const PlaylistScreen());
                        },
                      ),
                    );
                  },

                  /// Dot Indicator Widget
                  indicatorBuilder: (context, index) => DotIndicator(
                    color: index == 0 ? AppTheme.primaryColor1 : null,
                    size: 8,
                  ),

                  /// Line Connector Widger
                  connectorBuilder: (context, index, type) =>
                      SolidLineConnector(
                    color: index == 1 ? AppTheme.primaryColor1 : null,
                    thickness: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget(
      {required this.title,
      required this.weekNumber,
      required this.completedDays,
      required this.onPressedDay});
  final String title;
  final int weekNumber;
  final List<int> completedDays;
  final Function(int, int) onPressedDay;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        gapH8,
        Row(
          children: [
            for (int i = 0; i < 7; i++)
              Builder(
                builder: (context) {
                  final bool isCompleted = completedDays.contains(i);

                  return Expanded(
                    child: CustomInkWell(
                      onTap: () => onPressedDay(weekNumber, i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 1,
                        ),
                        height: 36,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppTheme.primaryColor1
                              : const Color(0xFF474747),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(i == 0 ? 20 : 0),
                            bottomLeft: Radius.circular(i == 0 ? 20 : 0),
                            topRight: Radius.circular(i == 6 ? 20 : 0),
                            bottomRight: Radius.circular(i == 6 ? 20 : 0),
                          ),
                        ),
                        child: isCompleted ? const Icon(Icons.check) : null,
                      ),
                    ),
                  );
                },
              ),
            gapW6,
            SvgPicture.asset(
              AppAssets.winMedalIcon,
              colorFilter: completedDays.length == 7
                  ? null
                  : const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
