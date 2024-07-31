// Project: 	   balanced_workout
// File:    	   course_screen
// Path:    	   lib/screens/main/user/courses/course_screen.dart
// Author:       Ali Akbar
// Date:        31-07-24 19:42:07 -- Wednesday
// Description:

import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_paddings.dart';
import 'package:balanced_workout/screens/components/custom_scaffold.dart';
import 'package:balanced_workout/screens/main/user/courses/progress_course_screen.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../blocs/course/course_bloc.dart';
import '../../../../blocs/course/course_event.dart';
import '../../../../blocs/course/course_state.dart';
import '../../../../models/course_model.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/enum.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_network_image.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen(
      {super.key, required this.selectedLevel, required this.selectedPeriod});
  final Level selectedLevel;
  final Period selectedPeriod;
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late Period selectedPeriod = widget.selectedPeriod;
  late Level selectedLevel = widget.selectedLevel;
  bool isLoading = false;
  List<CourseModel> courses = [];

  void triggerFetchCourseEvent() {
    context.read<CourseBloc>().add(
          CourseEventFetch(
              difficultyLevel: selectedLevel, period: selectedPeriod),
        );
  }

  @override
  void initState() {
    triggerFetchCourseEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseStateFetching ||
            state is CourseStateFetchFailure ||
            state is CourseStateFetched) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is CourseStateFetched) {
            setState(() {
              courses = state.courses;
            });
          }
        }
      },
      child: CustomScaffold(
        appBar: customAppBar(title: "Courses"),
        body: CustomPadding(
          top: 6,
          child: Skeletonizer(
            enabled: isLoading,
            child: (courses.isEmpty && !isLoading)
                ? const Center(
                    child: Text(
                      "No courses available",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: courses.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (_, index) {
                      final course = courses[index];
                      return CustomInkWell(
                        onTap: () {
                          NavigationService.go(
                              ProgressCourseScreen(course: course));
                        },
                        child: Container(
                          height: 193,
                          margin: const EdgeInsets.only(top: 7, bottom: 7),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: AppTheme.darkWidgetColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      const Color(0xff000000).withOpacity(0.35),
                                      BlendMode.srcOver),
                                  child: CustomNetworkImage(
                                    imageUrl: course.coverUrl,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 23,
                                right: 10,
                                bottom: 10,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.title,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
