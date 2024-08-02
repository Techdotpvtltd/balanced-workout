// Project: 	   balanced_workout
// File:    	   workout_bloc
// Path:    	   lib/blocs/workout/workout_bloc.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:18:28 -- Saturday
// Description:

import 'package:balanced_workout/blocs/workout/workout_event.dart';
import 'package:balanced_workout/blocs/workout/workout_state.dart';
import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/repos/workout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutStateInitial()) {
    /// On Fetch Event State
    on<WorkoutEventFetch>(
      (event, emit) async {
        try {
          emit(WorkoutStateFetching());
          final workouts = await WorkoutRepo().fetch(forLevel: event.forLevel);
          emit(WorkoutStateFetched(workouts: workouts));
        } on AppException catch (e) {
          emit(WorkoutStateFetchFailure(exception: e));
        }
      },
    );
  }
}
