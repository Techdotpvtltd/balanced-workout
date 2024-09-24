// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   workout_round_model
// Path:    	   lib/models/workout_round_model.dart
// Author:       Ali Akbar
// Date:        24-09-24 15:11:10 -- Tuesday
// Description:

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'plan_exercise_model.dart';

class WorkoutRoundModel {
  final int id;
  final int noOfSets;
  final int rest;
  final List<PlanExercise> exercises;
  WorkoutRoundModel({
    required this.id,
    required this.noOfSets,
    required this.rest,
    required this.exercises,
  });

  WorkoutRoundModel copyWith({
    int? id,
    int? noOfSets,
    int? rest,
    List<PlanExercise>? exercises,
  }) {
    return WorkoutRoundModel(
      id: id ?? this.id,
      noOfSets: noOfSets ?? this.noOfSets,
      rest: rest ?? this.rest,
      exercises: exercises ?? this.exercises,
    );
  }

  factory WorkoutRoundModel.fromMap(Map<String, dynamic> map) {
    return WorkoutRoundModel(
      id: map['id'] as int,
      noOfSets: map['noOfSets'] as int,
      rest: map['rest'] as int,
      exercises: (map['exercises'] as List<dynamic>)
          .map((e) => PlanExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'WorkoutRoundModel(id: $id, noOfSets: $noOfSets, rest: $rest, exercises: $exercises)';
  }

  @override
  bool operator ==(covariant WorkoutRoundModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.noOfSets == noOfSets &&
        other.rest == rest &&
        listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode {
    return id.hashCode ^ noOfSets.hashCode ^ rest.hashCode ^ exercises.hashCode;
  }
}
