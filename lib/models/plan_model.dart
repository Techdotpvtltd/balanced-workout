// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   plan_model
// Path:    	   lib/models/plan_model.dart
// Author:       Ali Akbar
// Date:        21-06-24 14:11:02 -- Friday
// Description:
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants/enum.dart';
import 'exercise_model.dart';
import 'set_model.dart';

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
}

class PlanExercise {
  final String uuid;
  final ExerciseModel exercise;
  final List<SetValueModel> sets;
  final String? note;
  final String? tempo;
  final List<PlanExercise> supersets;
  final DateTime addedAt;
  PlanExercise({
    required this.uuid,
    required this.exercise,
    required this.sets,
    this.note,
    this.tempo,
    required this.supersets,
    required this.addedAt,
  });

  factory PlanExercise.fromMap(Map<String, dynamic> map) {
    return PlanExercise(
      uuid: map['uuid'] as String,
      exercise: ExerciseModel.fromMap(map['exercise'] as Map<String, dynamic>),
      sets: (map['sets'] as List<dynamic>)
          .map((e) => SetValueModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      note: map['note'] != null ? map['note'] as String : null,
      tempo: map['tempo'] != null ? map['tempo'] as String : null,
      supersets: (map['supersets'] as List<dynamic>)
          .map((e) => PlanExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return 'PlanExercise(uuid: $uuid, exercise: $exercise, sets: $sets, note: $note, tempo: $tempo, supersets: $supersets, addedAt: $addedAt)';
  }
}
