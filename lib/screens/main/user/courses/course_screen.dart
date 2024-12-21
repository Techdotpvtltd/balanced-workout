// Project: 	   balanced_workout
// File:    	   course_screen
// Path:    	   lib/screens/main/user/courses/course_screen.dart
// Author:       Ali Akbar
// Date:        31-07-24 19:42:07 -- Wednesday
// Description:

import 'package:balanced_workout/app/store_manager.dart';
import 'package:balanced_workout/screens/components/custom_app_bar.dart';
import 'package:balanced_workout/screens/components/custom_paddings.dart';
import 'package:balanced_workout/screens/components/custom_scaffold.dart';
import 'package:balanced_workout/screens/main/user/courses/progress_course_screen.dart';
import 'package:balanced_workout/screens/main/user/settings/subscription_screen.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../blocs/course/course_bloc.dart';
import '../../../../blocs/course/course_event.dart';
import '../../../../blocs/course/course_state.dart';
import '../../../../blocs/subscription/subscription_state.dart';
import '../../../../blocs/subscription/subsription_bloc.dart';
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
  bool isReachedEnd = false;
  DocumentSnapshot? lastSnapDoc;
  final ScrollController scrollController = ScrollController();
  late bool isAllowContent = storeManager.hasSubscription;

  void addScrollListener() {
    scrollController.addListener(
      () {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          if (!isReachedEnd) triggerFetchCourseEvent();
        }
      },
    );
  }

  void triggerFetchCourseEvent() {
    context.read<CourseBloc>().add(
          CourseEventFetch(
            difficultyLevel: selectedLevel,
            period: selectedPeriod,
            lastSnapDoc: lastSnapDoc,
          ),
        );
  }

  @override
  void initState() {
    triggerFetchCourseEvent();
    addScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (_, state) {
            if (state is SubscriptionStateUpdated) {
              setState(() {
                isAllowContent = storeManager.hasSubscription;
              });
            }
          },
        ),
        BlocListener<CourseBloc, CourseState>(
          listener: (context, state) {
            if (state is CourseStateFetchLastSnapDoc) {
              isReachedEnd = state.lastSnapDoc == null;
              lastSnapDoc = state.lastSnapDoc;
            }
            if (state is CourseStateFetching ||
                state is CourseStateFetchFailure ||
                state is CourseStateFetched) {
              setState(() {
                isLoading = state.isLoading;
              });

              if (state is CourseStateFetched) {
                for (final course in state.courses) {
                  if (!courses.contains(course)) {
                    courses.add(course);
                  }
                }
                setState(() {});
              }
            }
          },
        ),
      ],
      child: CustomScaffold(
        appBar: customAppBar(title: "Courses"),
        body: CustomPadding(
          top: 6,
          child: Skeletonizer(
            enabled: isLoading && lastSnapDoc == null,
            child: (courses.isEmpty && !isLoading)
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Courses for this level will appear here.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Keep an eye out!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: courses.length,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (_, index) {
                      final course = courses[index];
                      return CustomInkWell(
                        onTap: () {
                          NavigationService.go(isAllowContent
                              ? ProgressCourseScreen(course: course)
                              : const SubscriptionScreen());
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
                                      const Color(0xff000000)
                                          .withValues(alpha: 0.35),
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
                              ),
                              if (!isAllowContent)
                                const Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: AppTheme.primaryColor1,
                                  ),
                                ),
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
