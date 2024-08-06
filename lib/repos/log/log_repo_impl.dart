// Project: 	   balanced_workout
// File:    	   log_repo_impl
// Path:    	   lib/repos/log/log_repo_impl.dart
// Author:       Ali Akbar
// Date:        06-08-24 16:12:19 -- Tuesday
// Description:

import 'dart:developer';

import 'package:balanced_workout/app/app_manager.dart';
import 'package:balanced_workout/app/cache_manager.dart';
import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/models/logs/workout_log_model.dart';
import 'package:balanced_workout/repos/log/log_repo_interface.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/constants/firebase_collections.dart';
import 'package:balanced_workout/web_services/firestore_services.dart';
import 'package:balanced_workout/web_services/query_model.dart';

class LogRepo implements LogRepoInterface {
  @override
  Future<void> getWorkouts() async {
    try {
      final List<Map<String, dynamic>> data =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_LOG_WORKOUTS,
        queries: [
          QueryModel(
            field: "userId",
            value: AppManager().user.uid,
            type: QueryType.isEqual,
          ),
          QueryModel(field: "startDate", value: true, type: QueryType.orderBy),
        ],
      );

      CacheLogWorkout().set =
          data.map((e) => WorkoutLogModel.fromMap(e)).toList();
    } catch (e) {
      log("", time: DateTime.now(), error: e, name: "WorkoutLog getWorkouts");
    }
  }

  @override
  Future<void> markWorkoutAsActive(
      {required String workoutId,
      required String name,
      required String coverUrl,
      required Level level}) async {
    try {
      /// If it already existed
      if (CacheLogWorkout().find(workoutId: workoutId)) {
        log("Already existed",
            time: DateTime.now(), name: "WorkoutLog markWorkoutAsActive");
        return;
      }

      final logWorkout = WorkoutLogModel(
        uuid: "",
        workoutId: workoutId,
        userId: AppManager().user.uid,
        name: name,
        difficultyLevel: level,
        startDate: DateTime.now(),
        isCompleted: false,
      );

      final Map<String, dynamic> map = await FirestoreService()
          .saveWithSpecificIdFiled(
              path: FIREBASE_COLLECTION_LOG_WORKOUTS,
              data: logWorkout.toMap(),
              docIdFiled: 'uuid');

      CacheLogWorkout().add(WorkoutLogModel.fromMap(map));
    } catch (e) {
      log("",
          time: DateTime.now(),
          error: e,
          name: "WorkoutLog markWorkoutAsActive");
    }
  }

  @override
  Future<List<WorkoutLogModel>> getWorkoutsBy({required Level level}) async {
    try {
      return CacheLogWorkout().getItemsBy(level: level);
    } catch (e) {
      log("", time: DateTime.now(), error: e, name: "WorkoutLog getWorkoutsBy");
      throw throwAppException(e: e);
    }
  }
}
