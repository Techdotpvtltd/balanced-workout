// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout
// File:    	   workout_log_model
// Path:    	   lib/models/logs/workout_log_model.dart
// Author:       Ali Akbar
// Date:        06-08-24 15:50:10 -- Tuesday
// Description:

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/constants/enum.dart';

class WorkoutLogModel {
  final String uuid;
  final String workoutId;
  final String userId;
  final String name;
  final String? coverUrl;
  final Level difficultyLevel;
  final DateTime startDate;
  final DateTime? completeDate;
  final bool isCompleted;
  WorkoutLogModel({
    required this.uuid,
    required this.workoutId,
    required this.userId,
    required this.name,
    this.coverUrl,
    required this.difficultyLevel,
    required this.startDate,
    this.completeDate,
    required this.isCompleted,
  });

  WorkoutLogModel copyWith({
    String? uuid,
    String? workoutId,
    String? userId,
    String? name,
    String? coverUrl,
    Level? difficultyLevel,
    DateTime? startDate,
    DateTime? completeDate,
    bool? isCompleted,
  }) {
    return WorkoutLogModel(
      uuid: uuid ?? this.uuid,
      workoutId: workoutId ?? this.workoutId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      coverUrl: coverUrl ?? this.coverUrl,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      startDate: startDate ?? this.startDate,
      completeDate: completeDate ?? this.completeDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'workoutId': workoutId,
      'userId': userId,
      'name': name,
      'coverUrl': coverUrl,
      'difficultyLevel': difficultyLevel.name.toLowerCase(),
      'startDate': Timestamp.fromDate(startDate),
      'completeDate':
          completeDate != null ? Timestamp.fromDate(completeDate!) : null,
      'isCompleted': isCompleted,
    };
  }

  factory WorkoutLogModel.fromMap(Map<String, dynamic> map) {
    return WorkoutLogModel(
      uuid: map['uuid'] as String,
      workoutId: map['workoutId'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      coverUrl: map['coverUrl'] != null ? map['coverUrl'] as String : null,
      difficultyLevel: Level.values.firstWhere((e) =>
          (map['difficultyLevel'] as String).toLowerCase() ==
          e.name.toLowerCase()),
      startDate: (map['startDate'] as Timestamp).toDate(),
      completeDate: (map['completeDate'] as Timestamp?)?.toDate(),
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutLogModel.fromJson(String source) =>
      WorkoutLogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkoutLogModel(uuid: $uuid, name: $name, coverUrl: $coverUrl, difficultyLevel: $difficultyLevel, startDate: $startDate, isCompleted: $isCompleted, userId: $userId, completeDate: $completeDate, workoutId $workoutId)';
  }

  @override
  bool operator ==(covariant WorkoutLogModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.workoutId == workoutId &&
        other.name == name &&
        other.coverUrl == coverUrl &&
        other.difficultyLevel == difficultyLevel &&
        other.startDate == startDate &&
        other.userId == userId &&
        other.completeDate == completeDate &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        workoutId.hashCode ^
        name.hashCode ^
        coverUrl.hashCode ^
        difficultyLevel.hashCode ^
        startDate.hashCode ^
        completeDate.hashCode ^
        userId.hashCode ^
        isCompleted.hashCode;
  }
}
