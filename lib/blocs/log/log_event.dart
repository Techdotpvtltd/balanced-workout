// Project: 	   balanced_workout
// File:    	   log_event
// Path:    	   lib/blocs/log/log_event.dart
// Author:       Ali Akbar
// Date:        06-08-24 16:50:13 -- Tuesday
// Description:

import 'package:balanced_workout/models/logs/course_log_model.dart';
import 'package:balanced_workout/models/logs/exercise_log_model.dart';
import 'package:balanced_workout/utils/constants/enum.dart';

abstract class LogEvent {}

// All Workout Logs

class LogEventFetchAllWorkouts extends LogEvent {}

/// Fetch Workouts by level
class LogEventFetchWorkoutsByLevel extends LogEvent {
  LogEventFetchWorkoutsByLevel();
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

class LogEventMarkWorkoutComplete extends LogEvent {
  final String workoutId;

  LogEventMarkWorkoutComplete({required this.workoutId});
}

/// Fetch Exercises
class LogEventFetchExercises extends LogEvent {}

class LogEventFetchExercisesBy extends LogEvent {
  final DateTime date;

  LogEventFetchExercisesBy({required this.date});
}

/// Save Exercises
class LogEventSaveExercise extends LogEvent {
  final ExerciseLogModel exercise;

  LogEventSaveExercise({required this.exercise});
}

/// Fetch Course Logs
class LogEventFetchCourse extends LogEvent {
  final String courseId;

  LogEventFetchCourse({required this.courseId});
}

class LogEventCourseUpdateWeekData extends LogEvent {
  final CourseWeekLogModel week;
  final String courseId;

  LogEventCourseUpdateWeekData({required this.week, required this.courseId});
}
