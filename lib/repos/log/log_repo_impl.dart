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
import 'package:balanced_workout/models/logs/exercise_log_model.dart';
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
      if (CacheLogWorkout().doesExisted(workoutId: workoutId)) {
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
        coverUrl: coverUrl,
        startDate: DateTime.now(),
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
  Future<void> markWorkoutCompleted({required String workoutId}) async {
    try {
      /// If it already existed
      WorkoutLogModel? logWrk = CacheLogWorkout().find(workoutId: workoutId);
      if (logWrk != null && logWrk.completeDate == null) {
        logWrk = logWrk.copyWith(completeDate: DateTime.now());
        await FirestoreService().updateWithDocId(
            path: FIREBASE_COLLECTION_LOG_WORKOUTS,
            docId: logWrk.uuid,
            data: logWrk.toMap());
        CacheLogWorkout().update(workout: logWrk);
      } else {
        log(
          "Workout log not found or already completed",
          time: DateTime.now(),
          name: "WorkoutLog markWorkoutCompleted",
        );

        throw Exception("Workout log not found");
      }
    } catch (e) {
      log("",
          time: DateTime.now(),
          error: e,
          name: "WorkoutLog markWorkoutCompleted");
      throw throwAppException(e: e);
    }
  }

  @override
  Future<List<WorkoutLogModel>> getWorkoutsBy() async {
    try {
      return CacheLogWorkout().getItem ?? [];
    } catch (e) {
      log("", time: DateTime.now(), error: e, name: "WorkoutLog getWorkoutsBy");
      throw throwAppException(e: e);
    }
  }

  @override
  Future<void> fetchExercisesForMonth() async {
    try {
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      DateTime currentDayOfMoth = DateTime(now.year, now.month + 1, now.day);
      final data = await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_LOG_EXERCISES,
        queries: [
          QueryModel(
            field: "userId",
            value: AppManager().user.uid,
            type: QueryType.isEqual,
          ),
          QueryModel(field: "startDate", value: true, type: QueryType.orderBy),
          QueryModel(
              field: "startDate",
              value: firstDayOfMonth,
              type: QueryType.isGreaterThanOrEqual),
          QueryModel(
              field: "startDate",
              value: currentDayOfMoth,
              type: QueryType.isLessThan),
        ],
      );

      final List<ExerciseLogModel> exercises =
          data.map((e) => ExerciseLogModel.fromMap(e)).toList();

      CacheLogExercise().set = exercises;
    } catch (e) {
      log("",
          time: DateTime.now(),
          error: e,
          name: "WorkoutLog fetchExercisesForMonth");
      throw throwAppException(e: e);
    }
  }

  @override
  Future<void> saveExercise({required ExerciseLogModel exercise}) async {
    try {
      if (CacheLogExercise().checkExistedBy(
          exerciseId: exercise.exerciseId, type: exercise.type)) {
        log("Exercise already logged",
            time: DateTime.now(),
            error: Exception(),
            name: "WorkoutLog saveExercise");
        throw throwAppException(e: Exception());
      }

      exercise = exercise.copyWith(completeDate: DateTime.now());
      final Map<String, dynamic> map = await FirestoreService()
          .saveWithSpecificIdFiled(
              path: FIREBASE_COLLECTION_LOG_EXERCISES,
              data: exercise.toMap(),
              docIdFiled: 'uuid');

      CacheLogExercise().add(ExerciseLogModel.fromMap(map));
    } catch (e) {
      log("", time: DateTime.now(), error: e, name: "WorkoutLog saveExercise");
      throw throwAppException(e: e);
    }
  }
}
