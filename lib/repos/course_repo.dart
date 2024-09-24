// Project: 	   balanced_workout
// File:    	   course_repo
// Path:    	   lib/repos/course_repo.dart
// Author:       Ali Akbar
// Date:        09-07-24 12:24:24 -- Tuesday
// Description:

import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/models/course_model.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/constants/firebase_collections.dart';
import 'package:balanced_workout/web_services/firestore_services.dart';
import 'package:balanced_workout/web_services/query_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class _CourseRepoInterface {
  Future<List<CourseModel>> fetch({
    required Level level,
    required Period period,
    DocumentSnapshot? lastDocSnap,
    required Function(DocumentSnapshot?) onLastSnap,
  });
}

class CourseRepo implements _CourseRepoInterface {
  @override
  Future<List<CourseModel>> fetch({
    required Level level,
    required Period period,
    DocumentSnapshot? lastDocSnap,
    required Function(DocumentSnapshot?) onLastSnap,
  }) async {
    try {
      final List<Map<String, dynamic>> data =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_COURSE,
        queries: [
          QueryModel(
            field: "period",
            value: period.name.toLowerCase(),
            type: QueryType.isEqual,
          ),
          QueryModel(
            field: "difficulty",
            value: [level.name.toLowerCase()],
            type: QueryType.whereIn,
          ),
          QueryModel(field: "title", value: false, type: QueryType.orderBy),
          QueryModel(field: "", value: 10, type: QueryType.limit),
          if (lastDocSnap != null)
            QueryModel(
                field: "",
                value: lastDocSnap,
                type: QueryType.startAfterDocument),
        ],
        lastDocSnapshot: (last) {
          onLastSnap(last);
        },
      );

      return data.map((e) => CourseModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      throw throwAppException(e: e);
    }
  }
}
