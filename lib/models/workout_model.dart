// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   workout_model
// Path:    	   lib/models/workout_model.dart
// Author:       Ali Akbar
// Date:        20-06-24 17:33:55 -- Thursday
// Description:

import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants/enum.dart';
import 'workout_round_model.dart';

class WorkoutModel {
  final String uuid;
  final String name;
  final String? coverUrl;
  final Level difficultyLevel;
  final String? description;
  final List<WorkoutRoundModel> rounds;
  final DateTime createdAt;
  final String createdBy;
  WorkoutModel({
    required this.uuid,
    required this.name,
    required this.difficultyLevel,
    this.description,
    this.coverUrl,
    required this.rounds,
    required this.createdAt,
    required this.createdBy,
  });

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      difficultyLevel: Level.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (map['difficultyLevel'] as String).toLowerCase()),
      description:
          map['description'] != null ? map['description'] as String : null,
      coverUrl: map['coverUrl'] != null ? map['coverUrl'] as String : null,
      rounds: (map['rounds'] as List<dynamic>? ?? [])
          .map((e) => WorkoutRoundModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
    );
  }

  @override
  String toString() {
    return 'WorkoutModel(uuid: $uuid, name: $name coverUrl, $coverUrl, difficultyLevel: $difficultyLevel, description: $description,rounds: $rounds, createdAt: $createdAt, createdBy: $createdBy)';
  }
}
