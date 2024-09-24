// Project: 	   balanced_workout
// File:    	   cardio_repo
// Path:    	   lib/repos/cardio_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 15:58:03 -- Friday
// Description:

import 'dart:async';
import 'dart:developer';

import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/repos/plan_repo.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plan_model.dart';

/// Cardio Impl
class CardioRepo extends PlanRepo {
  /// Fetch Cardio
  Future<List<PlanModel>> fetch({
    DocumentSnapshot? lastSnapDoc,
    required Function(DocumentSnapshot?) onLastSnap,
  }) async {
    try {
      // final CacheCardio cache = CacheCardio();
      // if (cache.getItem != null) {
      //   log("Getting from cache: ${cache.getItem?.name}");
      //   return cache.getItem!;
      // }

      final List<PlanModel> cardios = await super.fetchFor(
        type: PlanType.cardio,
        lastSnapDoc: lastSnapDoc,
        onLastSnap: (p0) => onLastSnap(p0),
      );
      // cache.set = cardio;
      return cardios;
    } catch (e) {
      log("Error: Fetch Cardio => $e");
      throw throwAppException(e: e);
    }
  }
}
