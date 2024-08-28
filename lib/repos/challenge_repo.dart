// Project: 	   balanced_workout
// File:    	   challenge_repo
// Path:    	   lib/repos/challenge_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 19:55:07 -- Friday
// Description:

import 'dart:developer';

import 'package:balanced_workout/app/cache_manager.dart';

import '../exceptions/exception_parsing.dart';
import '../models/plan_model.dart';
import '../utils/constants/enum.dart';
import 'plan_repo.dart';

class ChallengeRepo extends PlanRepo {
  /// Fetch Cardio
  Future<PlanModel> fetch() async {
    try {
      final CacheChallenege cache = CacheChallenege();
      if (cache.getItem != null) {
        log("Getting from cache: ${cache.getItem?.name}");
        return cache.getItem!;
      }

      final List<PlanModel> challenge = await super.fetchFor(
        type: PlanType.challenge,
        onLastSnap: (p0) {},
      );
      cache.set = challenge.first;
      return challenge.first;
    } catch (e) {
      log("Error: Fetch Challenge => $e");
      throw throwAppException(e: e);
    }
  }
}
