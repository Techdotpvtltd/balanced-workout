// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout
// File:    	   exercise_log_model
// Path:    	   lib/models/logs/exercise_log_model.dart
// Author:       Ali Akbar
// Date:        07-08-24 17:00:49 -- Wednesday
// Description:

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:balanced_workout/utils/constants/enum.dart';

class ExerciseLogModel {
  final String uuid;
  final String exerciseId;
  final String userId;
  final String title;
  final String coverUrl;
  final DateTime startDate;
  final DateTime? completeDate;
  final List<ExerciseMuscleType> muscles;
  final PlanType type;
  ExerciseLogModel({
    required this.uuid,
    required this.exerciseId,
    required this.userId,
    required this.title,
    required this.coverUrl,
    required this.startDate,
    this.completeDate,
    required this.muscles,
    required this.type,
  });

  ExerciseLogModel copyWith({
    String? uuid,
    String? exerciseId,
    String? userId,
    String? title,
    String? coverUrl,
    DateTime? startDate,
    DateTime? completeDate,
    List<ExerciseMuscleType>? muscles,
    PlanType? type,
  }) {
    return ExerciseLogModel(
      uuid: uuid ?? this.uuid,
      exerciseId: exerciseId ?? this.exerciseId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      startDate: startDate ?? this.startDate,
      completeDate: completeDate ?? this.completeDate,
      muscles: muscles ?? this.muscles,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'exerciseId': exerciseId,
      'userId': userId,
      'title': title,
      'coverUrl': coverUrl,
      'startDate': Timestamp.fromDate(startDate),
      'completeDate':
          completeDate != null ? Timestamp.fromDate(completeDate!) : null,
      'muscles': muscles.map((e) => e.name.toLowerCase()).toList(),
      'type': type.name.toLowerCase(),
    };
  }

  factory ExerciseLogModel.fromMap(Map<String, dynamic> map) {
    return ExerciseLogModel(
      uuid: map['uuid'] as String,
      exerciseId: map['exerciseId'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      coverUrl: map['coverUrl'] as String,
      startDate: (map['startDate'] as Timestamp).toDate(),
      completeDate: map['completeDate'] != null
          ? (map['completeDate'] as Timestamp).toDate()
          : null,
      muscles: ((map['muscles'] as List<dynamic>))
          .map((e) => ExerciseMuscleType.values.firstWhere(
              (m) => m.name.toLowerCase() == (e as String).toLowerCase()))
          .toList(),
      type: PlanType.values.firstWhere(
          (e) => e.name.toLowerCase() == map['type'].toString().toLowerCase()),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseLogModel.fromJson(String source) =>
      ExerciseLogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExerciseLogModel(uuid: $uuid, exerciseId: $exerciseId, userId: $userId, title: $title, coverUrl: $coverUrl, startDate: $startDate, completeDate: $completeDate, muscles: $muscles, type: $type)';
  }

  @override
  bool operator ==(covariant ExerciseLogModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.exerciseId == exerciseId &&
        other.userId == userId &&
        other.title == title &&
        other.coverUrl == coverUrl &&
        other.startDate == startDate &&
        other.completeDate == completeDate &&
        listEquals(other.muscles, muscles) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        exerciseId.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        coverUrl.hashCode ^
        startDate.hashCode ^
        completeDate.hashCode ^
        muscles.hashCode ^
        type.hashCode;
  }
}

enum ExerciseMuscleType {
  biceps('Biceps', 'biceps'),
  anterior('Deltoid(Anterior)', ''),
  lateral('Deltoid(Lateral)', ''),
  posterior('Deltoid(Posterior)', ''),
  chest('Chest', 'chest'),
  abdominalCore('Abdominal(Core)', ''),
  externalOblique('External oblique(Side core)', ''),
  upperTrapezius('Upper trapezius', ''),
  middleTrapezius('Middle Trapezius', ''),
  lowerTrapezius('Lower trapezius', ''),
  latissimusDorsiLats('Latissimus Dorsi(Lats)', ''),
  legsQuads('Legs(Quads)', ''),
  legsGlutes('Legs(Glutes)', ''),
  legsHamstrings('Legs(Hamstrings)', ''),
  legsCalfs('Legs(Calfs)', ''),
  triceps('Triceps', 'triceps');

  const ExerciseMuscleType(this.name, this.id);
  final String name, id;
}
