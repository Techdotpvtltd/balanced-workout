// Project: 	   muutsch
// File:    	   chat_event
// Path:    	   lib/blocs/chat/chat_event.dart
// Author:       Ali Akbar
// Date:        31-05-24 13:34:57 -- Friday
// Description:

import 'dart:core';

import 'package:balanced_workout/models/user_profile_model.dart';

abstract class ChatEvent {}

/// Fetch All Event
class ChatEventFetchAll extends ChatEvent {}

/// Create Chat Event
class ChatEventCreate extends ChatEvent {
  final String title;
  final String? avatar;
  final String? description;
  final int maxMembers;

  ChatEventCreate(
      {required this.title,
      this.avatar,
      this.description,
      required this.maxMembers});
}

/// Update Chat Event
class ChatEventUpdate extends ChatEvent {
  final String title;
  final String? avatar;
  final String? description;
  final int maxMembers;
  final String chatId;

  ChatEventUpdate(
      {required this.title,
      this.avatar,
      this.description,
      required this.chatId,
      required this.maxMembers});
}

class ChatEventJoin extends ChatEvent {
  final String chatId;

  ChatEventJoin({required this.chatId});
}

/// Remove Member
class ChatEventRemoveMember extends ChatEvent {
  final UserProfileModel member;
  final String chatId;
  ChatEventRemoveMember({required this.member, required this.chatId});
}
