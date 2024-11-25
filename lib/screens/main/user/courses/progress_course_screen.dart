// Project: 	   balanced_workout
// File:    	   progress_course_screen
// Path:    	   lib/screens/main/user/courses/progress_course_screen.dart
// Author:       Ali Akbar
// Date:        07-05-24 12:14:56 -- Tuesday
// Description:

import 'package:balanced_workout/blocs/log/log_bloc.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/blocs/log/log_state.dart';
import 'package:balanced_workout/models/course_model.dart';
import 'package:balanced_workout/models/logs/course_log_model.dart';
import 'package:balanced_workout/screens/main/user/courses/course_exercises_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../models/plan_exercise_model.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_paddings.dart';

class ProgressCourseScreen extends StatefulWidget {
  const ProgressCourseScreen({super.key, required this.course});
  final CourseModel course;
  @override
  State<ProgressCourseScreen> createState() => _ProgressCourseScreenState();
}

class _ProgressCourseScreenState extends State<ProgressCourseScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late final CourseModel course = widget.course;
  CourseLogModel? log;

  int leftDays = 0;

  void _setData() {
    setState(() {
      leftDays = course.weeks.expand((e) => e.days).length;
    });
    controller.animateTo(0);
  }

  void triggerFetchLogEvent() {
    context.read<LogBloc>().add(LogEventFetchCourse(courseId: course.uuid));
  }

  void triggerUpdateCourseWeekData(int week, int day) {
    final finalDay = (week * 7) + day;
    debugPrint(finalDay.toString());
    context.read<LogBloc>().add(
        LogEventCourseUpdateWeekData(day: finalDay, logId: log?.uuid ?? ""));
  }

  List<int> getCompletedDays(int week) {
    final List<int> days = [];
    final weekDays = List.generate(7, (int index) => (week * 7) + index + 1);
    for (int day in weekDays) {
      if (log?.completedDays.contains(day) ?? false) {
        days.add(day);
      }
    }

    return days;
  }

  @override
  void initState() {
    triggerFetchLogEvent();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    _setData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LogBloc, LogState>(
          listener: (_, state) {
            if (state is LogStateCouseFetched) {
              setState(() {
                log = state.course;
              });
            }

            if (state is LogStateCouseWeekDataUpdated) {
              triggerFetchLogEvent();
            }
          },
        )
      ],
      child: Scaffold(
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
                            Colors.black.withOpacity(0.6),
                            BlendMode.srcOver,
                          ),

                          /// Background Image
                          child: CustomNetworkImage(
                            imageUrl: course.coverUrl,
                          ),
                        ),
                      ),

                      /// Custom App Bar
                      Positioned(
                        child: customAppBar(title: course.title),
                      ),

                      /// Progress Show Widget
                      Positioned.fill(
                        child: CustomPadding(
                          bottom: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$leftDays ${leftDays > 1 ? "days" : "day"} Left",
                                    style: const TextStyle(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 29, vertical: 40),
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
                    itemCount: course.weeks.length,
                    contentsBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: _ContentWidget(
                          title: 'Week ${index + 1}',
                          completedDays: getCompletedDays(index),
                          weekNumber: index,
                          weekdata: course.weeks[index],
                          onPressedDay: (week, day, planExercises) {
                            NavigationService.go(
                              CourseExercisesScreen(
                                day: day,
                                week: week,
                                planExercises: planExercises,
                                onCompletedDay: (week, day) {
                                  triggerUpdateCourseWeekData(week, day);
                                },
                              ),
                            );
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
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget(
      {required this.title,
      required this.weekNumber,
      required this.completedDays,
      required this.onPressedDay,
      this.weekdata});
  final String title;
  final int weekNumber;
  final List<int> completedDays;
  final Function(int, int, List<PlanExercise>) onPressedDay;
  final CourseWeekModel? weekdata;
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
            for (int i = 1; i < 8; i++)
              Builder(
                builder: (context) {
                  final int finalDay = weekNumber * 7 + i;
                  final bool isCompleted = completedDays.contains(finalDay);
                  final int dayIndex =
                      weekdata?.days.indexWhere((e) => e.day == i) ?? -1;
                  bool isContainVideos = false;
                  if (dayIndex > -1) {
                    isContainVideos =
                        weekdata?.days[dayIndex].planExercises.isNotEmpty ??
                            false;
                  }

                  return Expanded(
                    child: CustomInkWell(
                      onTap: () {
                        if (isContainVideos) {
                          onPressedDay(weekNumber, i,
                              weekdata?.days[dayIndex].planExercises ?? []);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 1,
                        ),
                        height: 36,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppTheme.primaryColor1
                              : isContainVideos
                                  ? Colors.grey
                                  : const Color(0xFF474747),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(i == 1 ? 20 : 0),
                            bottomLeft: Radius.circular(i == 1 ? 20 : 0),
                            topRight: Radius.circular(i == 7 ? 20 : 0),
                            bottomRight: Radius.circular(i == 7 ? 20 : 0),
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
