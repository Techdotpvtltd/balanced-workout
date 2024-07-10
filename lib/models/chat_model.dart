// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   muutsch
// File:    	   chat_model
// Path:    	   lib/models/chat_model.dart
// Author:       Ali Akbar
// Date:        31-05-24 12:02:07 -- Friday
// Description:

import 'dart:convert';

import 'package:balanced_workout/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'user_profile_model.dart';

class ChatModel {
  final String uuid;
  final DateTime createdAt;
  final String createdBy;
  final List<UserProfileModel> participants;
  final List<String> participantUids;
  final String title;
  final int maxMemebrs;
  final String? avatar;
  final String? description;
  final MessageModel? lastMessage;
  ChatModel({
    required this.uuid,
    required this.createdAt,
    required this.createdBy,
    required this.participants,
    required this.participantUids,
    required this.maxMemebrs,
    required this.title,
    this.avatar,
    this.description,
    this.lastMessage,
  });

  ChatModel copyWith({
    String? uuid,
    DateTime? createdAt,
    String? createdBy,
    List<UserProfileModel>? participants,
    List<String>? participantUids,
    int? maxMemebrs,
    String? avatar,
    String? description,
    String? title,
    MessageModel? lastMessage,
  }) {
    return ChatModel(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      description: description ?? this.description,
      participants: participants ?? this.participants,
      participantUids: participantUids ?? this.participantUids,
      maxMemebrs: maxMemebrs ?? this.maxMemebrs,
      title: title ?? this.title,
      avatar: avatar ?? avatar,
      lastMessage: lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'participants': participants.map((x) => x.toMap()).toList(),
      'participantUids': participantUids,
      'maxMemebrs': maxMemebrs,
      'description': description,
      'title': title,
      'avatar': avatar,
      'lastMessage': lastMessage!.toMap(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
        uuid: map['uuid'] as String,
        createdAt: (map['createdAt'] as Timestamp).toDate(),
        createdBy: map['createdBy'] as String,
        description: map['description'] as String?,
        participants: (map['participants'] as List<dynamic>)
            .map((e) => UserProfileModel.fromMap(e))
            .toList(),
        participantUids: List<String>.from(map['participantUids'] as List),
        maxMemebrs:
            map['maxMemebrs'] == null ? 0 : map['maxMemebrs'] as int? ?? 0,
        title: map['title'] as String,
        avatar: map['avatar'] as String?,
        lastMessage:
            MessageModel.fromMap(map['lastMessage'] as Map<String, dynamic>));
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(uuid: $uuid, createdAt: $createdAt, createdBy: $createdBy, participants: $participants, participantUids: $participantUids, maxMemebrs: $maxMemebrs, title: $title, avatar: $avatar, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        listEquals(other.participants, participants) &&
        listEquals(other.participantUids, participantUids) &&
        other.maxMemebrs == maxMemebrs &&
        other.title == title &&
        other.lastMessage == lastMessage &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        createdAt.hashCode ^
        createdBy.hashCode ^
        participants.hashCode ^
        participantUids.hashCode ^
        maxMemebrs.hashCode ^
        title.hashCode ^
        lastMessage.hashCode ^
        avatar.hashCode;
  }
}
