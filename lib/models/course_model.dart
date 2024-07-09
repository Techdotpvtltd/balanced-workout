// Project: 	   balanced_workout
// File:    	   course_model
// Path:    	   lib/models/course_model.dart
// Author:       Ali Akbar
// Date:        09-07-24 12:21:14 -- Tuesday
// Description:

import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants/enum.dart';
import 'plan_model.dart';

class CourseModel {
  final String uuid;
  final DateTime createdAt;
  final String createdBy;
  final String title;
  final String description;
  final List<CourseWeekModel> weeks;
  final String coverUrl;
  final Period? period;
  final Level? difficulty;

  CourseModel({
    required this.uuid,
    required this.createdAt,
    required this.createdBy,
    required this.title,
    required this.description,
    required this.weeks,
    required this.coverUrl,
    this.period,
    this.difficulty,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      uuid: map['uuid'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      coverUrl: map['coverUrl'] as String,
      period: (map['period'] != null)
          ? Period.values.firstWhere((e) =>
              (map['period'] as String).toLowerCase() == e.name.toLowerCase())
          : Period.weekly,
      difficulty: (map['difficulty'] != null)
          ? Level.values.firstWhere((e) =>
              (map['difficulty'] as String).toLowerCase() ==
              e.name.toLowerCase())
          : Level.beginner,
      weeks: (map['weeks'] as List<dynamic>)
          .map((e) => CourseWeekModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CourseWeekModel {
  final int week;
  final List<CourseDayModel> days;
  CourseWeekModel({
    required this.week,
    required this.days,
  });

  factory CourseWeekModel.fromMap(Map<String, dynamic> map) {
    return CourseWeekModel(
      week: map['week'] as int,
      days: (map['days'] as List<dynamic>)
          .map((e) => CourseDayModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CourseDayModel {
  final int day;
  final List<PlanExercise> planExercises;
  CourseDayModel({
    required this.day,
    required this.planExercises,
  });

  factory CourseDayModel.fromMap(Map<String, dynamic> map) {
    return CourseDayModel(
      day: map['day'] as int,
      planExercises: (map['exercises'] as List<dynamic>)
          .map((e) => PlanExercise.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
