// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'article_model.dart';
import 'set_model.dart';
import 'video_model.dart';

// Project: 	   balanced_workout_panel
// File:    	   content_model
// Path:    	   lib/models/content_model.dart
// Author:       Ali Akbar
// Date:        06-06-24 13:10:43 -- Thursday
// Description:

class ExerciseModel {
  final String uuid;
  final String name;
  final String description;
  final int duration;
  final String createdBy;
  final DateTime createdAt;
  final VideoModel? video;
  final ArticleModel? article;
  final String? coverUrl;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final String modality;
  final List<SetModel> sets;
  final List<String> equipments;
  final List<String> steps;
  final String? note;
  final bool visibility;
  final String? difficulty;

  ExerciseModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.duration,
    required this.createdBy,
    required this.createdAt,
    this.video,
    this.article,
    this.coverUrl,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.modality,
    required this.sets,
    required this.equipments,
    required this.steps,
    this.note,
    this.difficulty,
    required this.visibility,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      difficulty: map['difficulty'] as String?,
      duration: map['duration'] as int,
      createdBy: map['createdBy'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      video: map['video'] != null
          ? VideoModel.fromMap(map['video'] as Map<String, dynamic>)
          : null,
      article: map['article'] != null
          ? ArticleModel.fromMap(map['article'] as Map<String, dynamic>)
          : null,
      coverUrl: map['coverUrl'] != null ? map['coverUrl'] as String : null,
      primaryMuscles: (map['primaryMuscles'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      secondaryMuscles: (map['secondaryMuscles'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      modality: map['modality'] as String,
      visibility: map['visibility'] as bool? ?? true,
      sets: (map['sets'] as List<dynamic>? ?? [])
          .map((e) => SetModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      equipments: (map['equipments'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      steps: (map['steps'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  @override
  String toString() {
    return 'ExerciseModel(uuid: $uuid, name: $name, description: $description, duration: $duration, createdBy: $createdBy, createdAt: $createdAt, video: $video, article: $article, coverUrl: $coverUrl, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, modality: $modality, sets: $sets, equipments: $equipments, steps: $steps, note: $note)';
  }
}
