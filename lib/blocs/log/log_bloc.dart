// Project: 	   balanced_workout
// File:    	   log_bloc
// Path:    	   lib/blocs/log/log_bloc.dart
// Author:       Ali Akbar
// Date:        06-08-24 16:55:01 -- Tuesday
// Description:

import 'package:balanced_workout/app/cache_manager.dart';
import 'package:balanced_workout/blocs/log/log_event.dart';
import 'package:balanced_workout/blocs/log/log_state.dart';
import 'package:balanced_workout/exceptions/app_exceptions.dart';
import 'package:balanced_workout/repos/log/log_repo_impl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc() : super(LogStateInitial()) {
    /// On Get All
    on<LogEventFetchAllWorkouts>(
      (event, emit) {
        LogRepo().getWorkouts();
      },
    );

    // By Level
    on<LogEventFetchWorkoutsByLevel>(
      (event, emit) async {
        try {
          emit(LogStateWorkoutsFetching());
          final workouts = await LogRepo().getWorkoutsBy(level: event.level);
          emit(LogStateWorkoutsFetched(workouts: workouts));
        } on AppException catch (e) {
          emit(LogStateWorkoutsFetchFailure(exception: e));
        }
      },
    );

    /// Save Workout Log
    on<LogEventSaveWorkout>(
      (event, emit) {
        LogRepo().markWorkoutAsActive(
            workoutId: event.workoutId,
            name: event.name,
            coverUrl: event.coverUrl ?? "",
            level: event.difficultyLevel);
      },
    );

    /// Save Exercie
    on<LogEventSaveExercise>(
      (event, emit) async {
        try {
          await LogRepo().saveExercise(exercise: event.exercise);
          emit(LogStateSavedExercise());
        } on AppException catch (_) {}
      },
    );

    /// Fetch AllExercises
    on<LogEventFetchExercises>(
      (event, emit) async {
        try {
          await LogRepo().fetchExercisesForMonth();
          emit(LogStateFetchedExercises());
        } on AppException catch (_) {}
      },
    );

    /// Fetch On Specific date
    on<LogEventFetchExercisesBy>(
      (event, emit) {
        final exercises = CacheLogExercise().findAt(event.date);
        emit(LogStateFetchedExercisesByDate(exercises: exercises));
      },
    );
  }
}
