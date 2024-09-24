// Project: 	   balanced_workout
// File:    	   workout_state
// Path:    	   lib/blocs/workout/workout_state.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:14:49 -- Saturday
// Description:

import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/models/workout_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class WorkoutStateFetchLastDocSnap extends WorkoutState {
  final DocumentSnapshot? lasSnapDoc;

  WorkoutStateFetchLastDocSnap({this.lasSnapDoc});
}

class WorkoutStateFetched extends WorkoutState {
  final List<WorkoutModel> workouts;

  WorkoutStateFetched({required this.workouts});
}

// ===========================Get Workout States================================

class WorkoutStateGetting extends WorkoutState {
  WorkoutStateGetting({super.isLoading = true});
}

class WorkoutStateGetFailue extends WorkoutState {
  final AppException exception;

  WorkoutStateGetFailue({required this.exception});
}

class WorkoutStateHGot extends WorkoutState {
  final WorkoutModel workout;

  WorkoutStateHGot({required this.workout});
}
