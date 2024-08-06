// Project: 	   balanced_workout
// File:    	   log_state
// Path:    	   lib/blocs/log/log_state.dart
// Author:       Ali Akbar
// Date:        06-08-24 16:45:06 -- Tuesday
// Description:

import 'package:balanced_workout/exceptions/app_exceptions.dart';

import '../../models/logs/workout_log_model.dart';

abstract class LogState {
  final bool isLoading;

  LogState({this.isLoading = false});
}

/// Initial State
class LogStateInitial extends LogState {}

// ===========================Get all workouts logs================================
class LogStateGotAllWorkouts extends LogState {}

// ===========================Get Workout Logs================================

class LogStateWorkoutsFetching extends LogState {
  LogStateWorkoutsFetching({super.isLoading = true});
}

class LogStateWorkoutsFetchFailure extends LogState {
  final AppException exception;

  LogStateWorkoutsFetchFailure({required this.exception});
}

class LogStateWorkoutsFetched extends LogState {
  final List<WorkoutLogModel> workouts;

  LogStateWorkoutsFetched({required this.workouts});
}
