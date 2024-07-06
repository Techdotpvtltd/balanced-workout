// Project: 	   balanced_workout
// File:    	   workout_event
// Path:    	   lib/blocs/workout/workout_event.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:17:27 -- Saturday
// Description:

import 'package:balanced_workout/utils/constants/enum.dart';

abstract class WorkoutEvent {}

/// Fetch Workout
class WorkoutEventFetch extends WorkoutEvent {
  final Level forLevel;

  WorkoutEventFetch({required this.forLevel});
}
