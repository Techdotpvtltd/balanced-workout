// Project: 	   balanced_workout
// File:    	   stretches_repo
// Path:    	   lib/repos/stretches_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 19:53:32 -- Friday
// Description:

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions/exception_parsing.dart';
import '../models/plan_model.dart';
import '../utils/constants/enum.dart';
import 'plan_repo.dart';

class StretchesRepo extends PlanRepo {
  /// Fetch Cardio
  Future<List<PlanModel>> fetch({
    DocumentSnapshot? lastSnapDoc,
    required Function(DocumentSnapshot?) onLastSnap,
  }) async {
    try {
      // final CacheStreches cache = CacheStreches();
      // if (cache.getItem != null) {
      //   log("Getting from cache: ${cache.getItem?.name}");
      //   return cache.getItem!;
      // }

      final List<PlanModel> stretches = await super.fetchFor(
        type: PlanType.stretches,
        lastSnapDoc: lastSnapDoc,
        onLastSnap: (p0) => onLastSnap(p0),
      );
      return stretches;
    } catch (e) {
      log("Error: Fetch Stretches => $e");
      throw throwAppException(e: e);
    }
  }
}
