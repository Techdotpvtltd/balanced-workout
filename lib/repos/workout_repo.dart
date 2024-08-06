// Project: 	   balanced_workout
// File:    	   workout_repo
// Path:    	   lib/repos/workout_repo.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:03:26 -- Saturday
// Description:

import 'dart:developer';

import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/models/workout_model.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/constants/firebase_collections.dart';
import 'package:balanced_workout/web_services/firestore_services.dart';
import 'package:balanced_workout/web_services/query_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepo {
  Future<List<WorkoutModel>> fetch({
    required Level forLevel,
    DocumentSnapshot? lastDocSnap,
    required Function(DocumentSnapshot?) onLastDocSnap,
  }) async {
    try {
      final List<Map<String, dynamic>> workouts =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_WORKOUTS,
        queries: [
          QueryModel(
              field: "difficultyLevel",
              value: forLevel.name.toLowerCase(),
              type: QueryType.isEqual),
          QueryModel(
            field: "name",
            value: false,
            type: QueryType.orderBy,
          ),
          QueryModel(
            field: "",
            value: 10,
            type: QueryType.limit,
          ),
          if (lastDocSnap != null)
            QueryModel(
                field: "",
                value: lastDocSnap,
                type: QueryType.startAfterDocument),
        ],
        lastDocSnapshot: (last) {
          onLastDocSnap(last);
        },
      );

      return workouts.map((e) => WorkoutModel.fromMap(e)).toList();
    } catch (e) {
      log("", time: DateTime.now(), error: e, name: "Workout Fetch");
      throw throwAppException(e: e);
    }
  }

  Future<WorkoutModel> getWorkout({required String uuid}) async {
    try {
      final Map<String, dynamic>? data = await FirestoreService()
          .fetchSingleRecord(path: FIREBASE_COLLECTION_WORKOUTS, docId: uuid);
      if (data != null) {
        return WorkoutModel.fromMap(data);
      }
      log("",
          time: DateTime.now(),
          error: Exception("Workout not found"),
          name: "Workout getWorkout");
      throw throwAppException(e: Exception("Workout not found"));
    } catch (e) {
      log("", time: DateTime.now(), error: e, name: "Workout getWorkout");
      throw throwAppException(e: e);
    }
  }
}
