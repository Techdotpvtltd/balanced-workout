// Project: 	   balanced_workout
// File:    	   cache_manager
// Path:    	   lib/app/cache_manager.dart
// Author:       Ali Akbar
// Date:        05-07-24 15:59:45 -- Friday
// Description:

import '../models/plan_model.dart';

class CacheManager {
  /// Singleton Instance
  static final CacheManager _instance = CacheManager._internal();
  CacheManager._internal();
  factory CacheManager() => _instance;
// ============================== Properties =============================
  PlanModel? _cardio;

  // ===========================Setters================================
  set setCardio(PlanModel item) => _cardio = item;
  // ===========================Getters================================

  /// Cardio Getters
  PlanModel? get cardio => _cardio;
  // ===========================Utility Methods================================

  void clear() {
    _cardio = null;
  }
}
