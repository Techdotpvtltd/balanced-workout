// Project: 	   balanced_workout
// File:    	   cache_manager
// Path:    	   lib/app/cache_manager.dart
// Author:       Ali Akbar
// Date:        05-07-24 15:59:45 -- Friday
// Description:

import '../models/plan_model.dart';

abstract class CacheManager<T> {
  T? _item;
  set set(T item) => _item = item;

  /// getter
  T? get getItem => _item;
}

// Cardio Manager
class CacheCardio implements CacheManager<PlanModel> {
  @override
  PlanModel? _item;

  @override
  PlanModel? get getItem => _item;

  @override
  set set(PlanModel item) => _item = item;
}
