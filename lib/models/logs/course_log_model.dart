// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// Project: 	   balanced_workout
// File:    	   course_log_model
// Path:    	   lib/models/logs/course_log_model.dart
// Author:       Ali Akbar
// Date:        01-11-24 22:39:02 -- Friday
// Description:

class CourseLogModel {
  final String uuid;
  final String courseId;
  final String userId;
  final DateTime startDate;
  final List<int> completedDays;
  CourseLogModel({
    required this.uuid,
    required this.courseId,
    required this.userId,
    required this.startDate,
    required this.completedDays,
  });

  CourseLogModel copyWith({
    String? uuid,
    String? courseId,
    String? userId,
    DateTime? startDate,
    List<int>? completedDays,
  }) {
    return CourseLogModel(
      uuid: uuid ?? this.uuid,
      courseId: courseId ?? this.courseId,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      completedDays: completedDays ?? this.completedDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'courseId': courseId,
      'userId': userId,
      'startDate': Timestamp.fromDate(startDate),
      'completedDays': completedDays,
    };
  }

  factory CourseLogModel.fromMap(Map<String, dynamic> map) {
    return CourseLogModel(
      uuid: map['uuid'] as String,
      courseId: map['courseId'] as String,
      userId: map['userId'] as String,
      startDate: (map['startDate'] as Timestamp).toDate(),
      completedDays:
          (map['completedDays'] as List<dynamic>).map((e) => e as int).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseLogModel.fromJson(String source) =>
      CourseLogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseLogModel(uuid: $uuid, courseId: $courseId, userId: $userId, startDate: $startDate, completedDays: $completedDays)';
  }

  @override
  bool operator ==(covariant CourseLogModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.courseId == courseId &&
        other.userId == userId &&
        other.startDate == startDate &&
        listEquals(other.completedDays, completedDays);
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        courseId.hashCode ^
        userId.hashCode ^
        startDate.hashCode ^
        completedDays.hashCode;
  }
}
