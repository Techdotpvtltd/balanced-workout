// Project: 	   balanced_workout
// File:    	   stretches_repo
// Path:    	   lib/repos/stretches_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 19:53:32 -- Friday
// Description:

import 'dart:developer';

import 'package:balanced_workout/app/cache_manager.dart';

import '../exceptions/exception_parsing.dart';
import '../models/plan_model.dart';
import '../utils/constants/enum.dart';
import 'plan_repo.dart';

class StretchesRepo extends PlanRepo {
  /// Fetch Cardio
  Future<PlanModel> fetch() async {
    try {
      final CacheStreches cache = CacheStreches();
      if (cache.getItem != null) {
        log("Getting from cache: ${cache.getItem?.name}");
        return cache.getItem!;
      }

      final PlanModel stretche = await super.fetchFor(type: PlanType.stretches);
      cache.set = stretche;
      return stretche;
    } catch (e) {
      log("Error: Fetch Stretches => $e");
      throw throwAppException(e: e);
    }
  }
}
