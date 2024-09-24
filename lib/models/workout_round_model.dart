// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   workout_round_model
// Path:    	   lib/models/workout_round_model.dart
// Author:       Ali Akbar
// Date:        24-09-24 15:11:10 -- Tuesday
// Description:

import 'package:flutter/foundation.dart';

class WorkoutRoundModel {
  final int id;
  final int noOfSets;
  final int rest;
  final List<WorkoutRoundModel> rounds;
  WorkoutRoundModel({
    required this.id,
    required this.noOfSets,
    required this.rest,
    required this.rounds,
  });

  WorkoutRoundModel copyWith({
    int? id,
    int? noOfSets,
    int? rest,
    List<WorkoutRoundModel>? rounds,
  }) {
    return WorkoutRoundModel(
      id: id ?? this.id,
      noOfSets: noOfSets ?? this.noOfSets,
      rest: rest ?? this.rest,
      rounds: rounds ?? this.rounds,
    );
  }

  factory WorkoutRoundModel.fromMap(Map<String, dynamic> map) {
    return WorkoutRoundModel(
      id: map['id'] as int,
      noOfSets: map['noOfSets'] as int,
      rest: map['rest'] as int,
      rounds: (map['rounds'] as List<dynamic>? ?? [])
          .map((e) => WorkoutRoundModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'WorkoutRoundModel(id: $id, noOfSets: $noOfSets, rest: $rest, rounds: $rounds)';
  }

  @override
  bool operator ==(covariant WorkoutRoundModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.noOfSets == noOfSets &&
        other.rest == rest &&
        listEquals(other.rounds, rounds);
  }

  @override
  int get hashCode {
    return id.hashCode ^ noOfSets.hashCode ^ rest.hashCode ^ rounds.hashCode;
  }
}
