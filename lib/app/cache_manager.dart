// Project: 	   balanced_workout
// File:    	   cache_manager
// Path:    	   lib/app/cache_manager.dart
// Author:       Ali Akbar
// Date:        05-07-24 15:59:45 -- Friday
// Description:

import 'package:balanced_workout/models/logs/workout_log_model.dart';
import 'package:balanced_workout/models/workout_model.dart';

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
  @override
  List<WorkoutLogModel>? _item;

  @override
  List<WorkoutLogModel>? getItem;

  @override
  set set(List<WorkoutLogModel> item) => _item?.addAll(item);

  bool find({required String workoutId}) =>
      (_item?.indexWhere((e) => e.workoutId == workoutId) ?? -1) > -1;

  void add(WorkoutLogModel workout) =>
      !find(workoutId: workout.uuid) ? _item?.add(workout) : {};
}
