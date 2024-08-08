// Project: 	   balanced_workout
// File:    	   cache_manager
// Path:    	   lib/app/cache_manager.dart
// Author:       Ali Akbar
// Date:        05-07-24 15:59:45 -- Friday
// Description:

import 'package:balanced_workout/models/logs/exercise_log_model.dart';
import 'package:balanced_workout/models/logs/workout_log_model.dart';
import 'package:balanced_workout/models/workout_model.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';

import '../models/plan_model.dart';

abstract class CacheManager<T> {
  T? _item;
  set set(T item) => _item = item;

  /// getter
  T? get getItem => _item;
}

// Cardio Manager
class CacheCardio implements CacheManager<PlanModel> {
  static final _instance = CacheCardio._internal();
  CacheCardio._internal();
  factory CacheCardio() => _instance;

  @override
  PlanModel? _item;

  @override
  PlanModel? get getItem => _item;

  @override
  set set(PlanModel item) => _item = item;
}

// Stretches Manager
class CacheStreches implements CacheManager<PlanModel> {
  static final _instance = CacheStreches._internal();
  CacheStreches._internal();
  factory CacheStreches() => _instance;

  @override
  PlanModel? _item;

  @override
  PlanModel? get getItem => _item;

  @override
  set set(PlanModel item) => _item = item;
}

// Challenges Manager
class CacheChallenege implements CacheManager<PlanModel> {
  static final _instance = CacheChallenege._internal();
  CacheChallenege._internal();
  factory CacheChallenege() => _instance;

  @override
  PlanModel? _item;

  @override
  PlanModel? get getItem => _item;

  @override
  set set(PlanModel item) => _item = item;
}

// Challenges Manager
class CacheWorkout implements CacheManager<WorkoutModel> {
  static final _instance = CacheWorkout._internal();
  CacheWorkout._internal();
  factory CacheWorkout() => _instance;

  @override
  WorkoutModel? _item;

  @override
  WorkoutModel? get getItem => _item;

  @override
  set set(WorkoutModel item) => _item = item;
}

/// Log Workouts
class CacheLogWorkout implements CacheManager<List<WorkoutLogModel>> {
  static final _instance = CacheLogWorkout._internal();
  CacheLogWorkout._internal();
  factory CacheLogWorkout() => _instance;
  @override
  List<WorkoutLogModel>? _item;

  @override
  late List<WorkoutLogModel>? getItem = _item;

  @override
  set set(List<WorkoutLogModel> item) => _item = item;

  bool doesExisted({required String workoutId}) =>
      (_item?.indexWhere((e) => e.workoutId == workoutId) ?? -1) > -1;

  WorkoutLogModel? find({required String workoutId}) {
    final int index = _item?.indexWhere((e) => e.workoutId == workoutId) ?? -1;
    if (index > -1) {
      return _item![index];
    }
    return null;
  }

  void update({required WorkoutLogModel workout}) {
    final int index = _item?.indexWhere((e) => e.uuid == workout.uuid) ?? -1;

    if (index > -1) {
      _item![index] = workout;
      debugPrint("Completed");
    }
  }

  void add(WorkoutLogModel workout) =>
      !doesExisted(workoutId: workout.uuid) ? _item?.add(workout) : {};
  List<WorkoutLogModel> getItemsBy({required Level level}) =>
      _item?.where((e) => e.difficultyLevel == level).toList() ?? [];
}

class CacheLogExercise implements CacheManager<List<ExerciseLogModel>> {
  static final _instance = CacheLogExercise._internal();
  CacheLogExercise._internal();
  factory CacheLogExercise() => _instance;

  @override
  List<ExerciseLogModel>? _item;

  @override
  late List<ExerciseLogModel>? getItem = _item;

  @override
  set set(List<ExerciseLogModel> item) => _item = item;

  void add(ExerciseLogModel log) => _item?.insert(0, log);

  List<ExerciseLogModel> findAt(DateTime date) =>
      _item?.where((e) => e.startDate.onlyDate() == date.onlyDate()).toList() ??
      [];
  List<ExerciseLogModel> findBy(PlanType type) =>
      _item?.where((e) => e.type == type).toList() ?? [];

  bool checkExistedBy({required String exerciseId, required PlanType type}) =>
      (_item?.indexWhere((e) => e.exerciseId == exerciseId && e.type == type) ??
          -1) >
      -1;
}
