// Project: 	   balanced_workout
// File:    	   course_bloc
// Path:    	   lib/blocs/course/course_bloc.dart
// Author:       Ali Akbar
// Date:        09-07-24 12:59:23 -- Tuesday
// Description:

import 'package:balanced_workout/blocs/course/course_event.dart';
import 'package:balanced_workout/blocs/course/course_state.dart';
import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/repos/course_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseStateInitial()) {
    /// on Fetch All Course Events
    on<CourseEventFetch>(
      (event, emit) async {
        try {
          emit(CourseStateFetching());
          final courses = await CourseRepo()
              .fetch(level: event.difficultyLevel, period: event.period);
          emit(CourseStateFetched(courses: courses));
        } on AppException catch (e) {
          emit(CourseStateFetchFailure(exception: e));
        }
      },
    );
  }
}
