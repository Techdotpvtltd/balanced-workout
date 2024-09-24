// Project: 	   balanced_workout
// File:    	   plan_repo
// Path:    	   lib/repos/plan_repo.dart
// Author:       Ali Akbar
// Date:        05-07-24 17:54:01 -- Friday
// Description:

import 'dart:developer';

import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions/exception_parsing.dart';
import '../models/plan_model.dart';
import '../utils/constants/firebase_collections.dart';
import '../web_services/firestore_services.dart';
import '../web_services/query_model.dart';

abstract class PlanRepo {
  Future<List<PlanModel>> fetchFor({
    required PlanType type,
    DocumentSnapshot? lastSnapDoc,
    required Function(DocumentSnapshot?) onLastSnap,
  }) async {
    try {
      final List<Map<String, dynamic>> data =
          // ignore: deprecated_member_use_from_same_package
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_PLANS,
        queries: [
          QueryModel(
              field: "type",
              value: type.name.toLowerCase(),
              type: QueryType.isEqual),
          QueryModel(field: "name", value: false, type: QueryType.orderBy),
          QueryModel(field: "", value: 10, type: QueryType.limit),
          if (lastSnapDoc != null)
            QueryModel(
                field: "",
                value: lastSnapDoc,
                type: QueryType.startAfterDocument)
        ],
        lastDocSnapshot: (p0) => onLastSnap(p0),
      );

      if (data.isEmpty) {
        throw throwAppException(e: Exception('No items found.'));
      }
      return data.map((e) => PlanModel.fromMap(e)).toList();
    } catch (e) {
      log("Error: $type => $e");
      throw throwAppException(e: e);
    }
  }
}
