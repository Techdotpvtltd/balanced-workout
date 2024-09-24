// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// Project: 	   balanced_workout_panel
// File:    	   article_model
// Path:    	   lib/models/article_model.dart
// Author:       Ali Akbar
// Date:        31-07-24 15:35:35 -- Wednesday
// Description:

class ArticleModel {
  final String uuid;
  final String title;
  final String data;
  final DateTime createdAt;
  final String createdBy;
  final String? cover;
  final bool isActive;
  ArticleModel({
    required this.uuid,
    required this.title,
    required this.data,
    required this.createdAt,
    required this.createdBy,
    this.cover,
    required this.isActive,
  });

  ArticleModel copyWith({
    String? uuid,
    String? title,
    String? data,
    DateTime? createdAt,
    String? createdBy,
    String? cover,
    bool? isActive,
  }) {
    return ArticleModel(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      isActive: isActive ?? this.isActive,
      cover: cover ?? this.cover,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'title': title,
      'data': data,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'isActive': isActive,
      'cover': cover,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      uuid: map['uuid'] as String,
      title: map['title'] as String,
      data: map['data'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
      cover: map['cover'],
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArticleModel(uuid: $uuid, title: $title, data: $data, createdAt: $createdAt, createdBy: $createdBy, isActive: $isActive, cover: $cover)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.title == title &&
        other.data == data &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        other.cover == cover &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        title.hashCode ^
        data.hashCode ^
        createdAt.hashCode ^
        createdBy.hashCode ^
        isActive.hashCode;
  }
}
