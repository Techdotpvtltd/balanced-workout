// Project: 	   balanced_workout
// File:    	   log_repo_interface
// Path:    	   lib/repos/log/log_repo_interface.dart
// Author:       Ali Akbar
// Date:        06-08-24 15:58:08 -- Tuesday
// Description:

import 'package:balanced_workout/models/logs/workout_log_model.dart';

import '../../utils/constants/enum.dart';

abstract class LogRepoInterface {
  Future<void> markWorkoutAsActive({
    required String workoutId,
    required String name,
    required String coverUrl,
    required Level level,
  });

  Future<void> getWorkouts();
  Future<List<WorkoutLogModel>> getWorkoutsBy({required Level level});
}
