// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   workout_model
// Path:    	   lib/models/workout_model.dart
// Author:       Ali Akbar
// Date:        20-06-24 17:33:55 -- Thursday
// Description:

import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants/enum.dart';
import 'exercise_model.dart';
import 'set_model.dart';

class WorkoutModel {
  final String uuid;
  final String name;
  final String? coverUrl;
  final Level difficultyLevel;
  final String? description;
  final List<WorkoutExercise> exercises;
  final DateTime createdAt;
  final String createdBy;
  WorkoutModel({
    required this.uuid,
    required this.name,
    required this.difficultyLevel,
    this.description,
    this.coverUrl,
    required this.exercises,
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
      exercises: (map['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
    );
  }

  @override
  String toString() {
    return 'WorkoutModel(uuid: $uuid, name: $name coverUrl, $coverUrl, difficultyLevel: $difficultyLevel, description: $description, exercises: $exercises, createdAt: $createdAt, createdBy: $createdBy)';
  }
}

class WorkoutExercise {
  final String uuid;
  final ExerciseModel exercise;
  final List<SetValueModel> sets;
  final String? note;
  final String? tempo;
  final List<WorkoutExercise> supersets;
  final DateTime addedAt;
  WorkoutExercise({
    required this.uuid,
    required this.exercise,
    required this.sets,
    this.note,
    this.tempo,
    required this.supersets,
    required this.addedAt,
  });

  factory WorkoutExercise.fromMap(Map<String, dynamic> map) {
    return WorkoutExercise(
      uuid: map['uuid'] as String,
      exercise: ExerciseModel.fromMap(map['exercise'] as Map<String, dynamic>),
      sets: (map['sets'] as List<dynamic>)
          .map((e) => SetValueModel.fromMap((e as Map<String, dynamic>)))
          .toList(),
      note: map['note'] != null ? map['note'] as String : null,
      tempo: map['tempo'] != null ? map['tempo'] as String : null,
      supersets: (map['supersets'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return 'WorkoutExercise(uuid: $uuid, exercise: $exercise, sets: $sets, note: $note, tempo: $tempo, supersets: $supersets, addedAt: $addedAt)';
  }
}
