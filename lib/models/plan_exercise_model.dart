import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise_model.dart';
import 'set_model.dart';

class PlanExercise {
  final String uuid;
  final ExerciseModel exercise;
  final List<List<SetValueModel>> setsValue;
  final String? note;
  final String? tempo;
  final List<PlanExercise> supersets;
  final DateTime addedAt;
  PlanExercise({
    required this.uuid,
    required this.exercise,
    required this.setsValue,
    this.note,
    this.tempo,
    required this.supersets,
    required this.addedAt,
  });

  factory PlanExercise.fromMap(Map<String, dynamic> map) {
    return PlanExercise(
      uuid: map['uuid'] as String,
      exercise: ExerciseModel.fromMap(map['exercise'] as Map<String, dynamic>),
      setsValue: map['setsValue'] != null
          ? _convertListMapToNestedListOfSetValue(map['setsValue'])
          : [],
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
    return 'PlanExercise(uuid: $uuid, exercise: $exercise, sets: $setsValue, note: $note, tempo: $tempo, supersets: $supersets, addedAt: $addedAt)';
  }
}

List<List<SetValueModel>> _convertListMapToNestedListOfSetValue(
    List<dynamic> flattenedSets) {
// Determine the size of the matrix (rows and columns)
  if (flattenedSets.isEmpty) {
    return [];
  }
  int maxRow = 0;
  int maxCol = 0;

  for (var set in flattenedSets) {
    if (set['row'] > maxRow) maxRow = set['row'];
    if (set['col'] > maxCol) maxCol = set['col'];
  }

  List<List<SetValueModel>> sets = List.generate(
    maxRow + 1,
    (row) => List.generate(
      maxCol + 1,
      (col) => SetValueModel(row: row, col: col),
    ),
  );

  for (var set in flattenedSets) {
    int row = set['row'];
    int col = set['col'];
    sets[row][col] = SetValueModel.fromMap(set);
  }

  return sets;
}
