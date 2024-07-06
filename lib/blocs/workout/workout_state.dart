// Project: 	   balanced_workout
// File:    	   workout_state
// Path:    	   lib/blocs/workout/workout_state.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:14:49 -- Saturday
// Description:

import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/models/workout_model.dart';

abstract class WorkoutState {
  final bool isLoading;

  WorkoutState({this.isLoading = false});
}

/// initial state
class WorkoutStateInitial extends WorkoutState {}

// ===========================Fetch Workout States================================

class WorkoutStateFetching extends WorkoutState {
  WorkoutStateFetching({super.isLoading = true});
}

class WorkoutStateFetchFailure extends WorkoutState {
  final AppException exception;

  WorkoutStateFetchFailure({required this.exception});
}

class WorkoutStateFetched extends WorkoutState {
  final WorkoutModel model;

  WorkoutStateFetched({required this.model});
}
