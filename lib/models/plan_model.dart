// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   plan_model
// Path:    	   lib/models/plan_model.dart
// Author:       Ali Akbar
// Date:        21-06-24 14:11:02 -- Friday
// Description:
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constants/enum.dart';
import 'plan_exercise_model.dart';

class PlanModel {
  final String uuid;
  final String name;
  final String? coverUrl;
  final Level difficultyLevel;
  final PlanType type;
  final Period? period;
  final List<PlanExercise> exercises;
  final DateTime createdAt;
  final String createdBy;
  PlanModel({
    required this.uuid,
    required this.name,
    this.coverUrl,
    required this.difficultyLevel,
    required this.type,
    this.period,
    required this.exercises,
    required this.createdAt,
    required this.createdBy,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      coverUrl: map['coverUrl'] != null ? map['coverUrl'] as String : null,
      difficultyLevel: Level.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (map['difficultyLevel'] as String).toLowerCase()),
      type: PlanType.values.firstWhere((element) =>
          element.name.toLowerCase() == (map['type'] as String).toLowerCase()),
      period: map['period'] != null
          ? Period.values.firstWhere((element) =>
              element.name.toLowerCase() ==
              (map['period'] as String).toLowerCase())
          : null,
      exercises: (map['exercises'] as List<dynamic>)
          .map((e) => PlanExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
    );
  }

  @override
  String toString() {
    return 'PlanModel(uuid: $uuid, name: $name, coverUrl: $coverUrl, difficultyLevel: $difficultyLevel, type: $type, period: $period, exercises: $exercises, createdAt: $createdAt, createdBy: $createdBy)';
  }

  PlanModel copyWith({
    String? uuid,
    String? name,
    String? coverUrl,
    Level? difficultyLevel,
    PlanType? type,
    Period? period,
    List<PlanExercise>? exercises,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return PlanModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      coverUrl: coverUrl ?? this.coverUrl,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      type: type ?? this.type,
      period: period ?? this.period,
      exercises: exercises ?? this.exercises,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
