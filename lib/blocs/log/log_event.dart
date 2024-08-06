// Project: 	   balanced_workout
// File:    	   log_event
// Path:    	   lib/blocs/log/log_event.dart
// Author:       Ali Akbar
// Date:        06-08-24 16:50:13 -- Tuesday
// Description:

import 'package:balanced_workout/utils/constants/enum.dart';

abstract class LogEvent {}

// All Workout Logs

class LogEventFetchAllWorkouts extends LogEvent {}

/// Fetch Workouts by level
class LogEventFetchWorkoutsByLevel extends LogEvent {
  final Level level;

  LogEventFetchWorkoutsByLevel({required this.level});
}

/// Save Workout log
class LogEventSaveWorkout extends LogEvent {
  final String workoutId;
  final String name;
  final String? coverUrl;
  final Level difficultyLevel;

  LogEventSaveWorkout(
      {required this.workoutId,
      required this.name,
      required this.coverUrl,
      required this.difficultyLevel});
}
