// Project: 	   balanced_workout
// File:    	   cardio_repo
// Path:    	   lib/repos/cardio_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 15:58:03 -- Friday
// Description:

import 'dart:async';
import 'dart:developer';

import 'package:balanced_workout/app/cache_manager.dart';
import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/repos/plan_repo.dart';
import 'package:balanced_workout/utils/constants/enum.dart';

import '../models/plan_model.dart';

/// Cardio Impl
class CardioRepo extends PlanRepo {
  /// Fetch Cardio
  Future<PlanModel> fetch() async {
    try {
      final CacheManager cache = CacheManager();
      if (cache.cardio != null) {
        return cache.cardio!;
      }

      final PlanModel cardio = await super.fetchFor(type: PlanType.cardio);
      cache.setCardio = cardio;
      return cardio;
    } catch (e) {
      log("Error: Fetch Cardio => $e");
      throw throwAppException(e: e);
    }
  }
}
