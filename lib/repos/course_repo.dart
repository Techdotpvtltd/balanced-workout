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
import 'package:flutter/material.dart';

abstract class _CourseRepoInterface {
  Future<List<CourseModel>> fetchAll(
      {required Level level, required Period period});
}

mixin _CourseRepoInterfaceMixin on _CourseRepoInterface {
  @override
  Future<List<CourseModel>> fetchAll(
      {required Level level, required Period period}) {
    throw UnimplementedError();
  }
}

class CourseRepo extends _CourseRepoInterface with _CourseRepoInterfaceMixin {
  @override
  Future<List<CourseModel>> fetchAll(
      {required Level level, required Period period}) async {
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
            field: "period",
            value: period.name.toLowerCase(),
            type: QueryType.isEqual,
          ),
        ],
      );

      return data.map((e) => CourseModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
      throw throwAppException(e: e);
    }
  }
}
