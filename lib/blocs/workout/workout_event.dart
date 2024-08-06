// Project: 	   balanced_workout
// File:    	   workout_event
// Path:    	   lib/blocs/workout/workout_event.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:17:27 -- Saturday
// Description:

import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WorkoutEvent {}

/// Fetch Workout
class WorkoutEventFetch extends WorkoutEvent {
  final Level forLevel;
  final DocumentSnapshot? lastSnapDoc;
  WorkoutEventFetch({
    required this.forLevel,
    this.lastSnapDoc,
  });
}

class WorkoutEventGet extends WorkoutEvent {
  final String uuid;

  WorkoutEventGet({required this.uuid});
}
