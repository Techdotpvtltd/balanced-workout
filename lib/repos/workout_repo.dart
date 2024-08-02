// Project: 	   balanced_workout
// File:    	   workout_repo
// Path:    	   lib/repos/workout_repo.dart
// Author:       Ali Akbar
// Date:        06-07-24 13:03:26 -- Saturday
// Description:

import 'package:balanced_workout/exceptions/exception_parsing.dart';
import 'package:balanced_workout/models/workout_model.dart';
import 'package:balanced_workout/utils/constants/enum.dart';
import 'package:balanced_workout/utils/constants/firebase_collections.dart';
import 'package:balanced_workout/web_services/firestore_services.dart';
import 'package:balanced_workout/web_services/query_model.dart';

class WorkoutRepo {
  Future<List<WorkoutModel>> fetch({required Level forLevel}) async {
    try {
      final List<Map<String, dynamic>> workouts =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_WORKOUTS,
        queries: [
          QueryModel(
              field: "difficultyLevel",
              value: forLevel.name.toLowerCase(),
              type: QueryType.isEqual),
          // QueryModel(
          //   field: "",
          //   value: 1,
          //   type: QueryType.limit,
          // ),
        ],
      );

      return workouts.map((e) => WorkoutModel.fromMap(e)).toList();
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

  // final List<WorkoutModel> workouts =
  //       await WebServices().fetchMultipleWithConditions<WorkoutModel>(
  //     collection: FIREBASE_COLLECTION_WORKOUTS,
  //     queries: [
  //       QueryModel(
  //           field: "difficultyLevel",
  //           value: forLevel.name.toLowerCase(),
  //           type: QueryType.isEqual),
  //       QueryModel(field: "", value: 1, type: QueryType.limit),
  //     ],
  //   );
  //   if (workouts.isNotEmpty) {
  //     return workouts.first;
  //   }
  //   throw throwAppException(e: DataExceptionNotFound());
  // }
}
