// Project: 	   balanced_workout
// File:    	   plan_repo
// Path:    	   lib/repos/plan_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 17:54:01 -- Friday
// Description:

import 'dart:developer';

import 'package:balanced_workout/utils/constants/enum.dart';

import '../exceptions/exception_parsing.dart';
import '../models/plan_model.dart';
import '../utils/constants/firebase_collections.dart';
import '../web_services/firestore_services.dart';
import '../web_services/query_model.dart';

abstract class PlanRepo {
  Future<PlanModel> fetchFor({required PlanType type}) async {
    try {
      final List<Map<String, dynamic>> map =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_PLANS,
        queries: [
          QueryModel(field: "type", value: type, type: QueryType.isEqual),
          QueryModel(field: "", value: 1, type: QueryType.limit),
        ],
      );

      if (map.isEmpty) {
        throw throwAppException(e: Exception('No items found.'));
      }
      return PlanModel.fromMap(map.first);
    } catch (e) {
      log("Error: $type => $e");
      throw throwAppException(e: e);
    }
  }
}
