// Project: 	   balanced_workout
// File:    	   course_event
// Path:    	   lib/blocs/course/course_event.dart
// Author:       Ali Akbar
// Date:        09-07-24 12:58:22 -- Tuesday
// Description:

import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CourseEvent {}

/// Fetch Course Event

class CourseEventFetch extends CourseEvent {
  final Level difficultyLevel;
  final Period period;
  final DocumentSnapshot? lastSnapDoc;
  CourseEventFetch({
    required this.difficultyLevel,
    required this.period,
    this.lastSnapDoc,
  });
}
