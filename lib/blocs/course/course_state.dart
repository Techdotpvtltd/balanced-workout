// Project: 	   balanced_workout
// File:    	   course_state
// Path:    	   lib/blocs/course/course_state.dart
// Author:       Ali Akbar
// Date:        09-07-24 12:55:35 -- Tuesday
// Description:

import 'package:balanced_workout/exceptions/app_exceptions.dart';

import '../../models/course_model.dart';

abstract class CourseState {
  final bool isLoading;

  CourseState({this.isLoading = false});
}

/// Initial States
class CourseStateInitial extends CourseState {}

// ===========================Fetch Course States================================

class CourseStateFetching extends CourseState {
  CourseStateFetching({super.isLoading = true});
}

class CourseStateFetchFailure extends CourseState {
  final AppException exception;

  CourseStateFetchFailure({required this.exception});
}

class CourseStateFetched extends CourseState {
  final List<CourseModel> courses;

  CourseStateFetched({required this.courses});
}
