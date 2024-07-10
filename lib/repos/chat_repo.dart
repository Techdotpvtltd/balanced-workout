// Project: 	   muutsch
// File:    	   chat_repo
// Path:    	   lib/repos/chat_repo.dart
// Author:       Ali Akbar
// Date:        31-05-24 11:59:48 -- Friday
// Description:

import 'dart:developer';
import 'dart:io';

import 'package:balanced_workout/app/app_manager.dart';
import 'package:balanced_workout/models/message_model.dart';
import 'package:balanced_workout/models/user_profile_model.dart';
import 'package:balanced_workout/repos/validations/check_validation.dart';
import 'package:balanced_workout/web_services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../exceptions/app_exceptions.dart';
import '../exceptions/exception_parsing.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';
import '../utils/constants/firebase_collections.dart';
import '../web_services/firestore_services.dart';
import '../web_services/query_model.dart';

class ChatRepo {
  final UserModel user = AppManager().user;

  // ===========================Methods================================

  void clearAll() {}

  Future<void> fetchChats({
    required Function(ChatModel) onAdded,
    required Function(ChatModel) onDeleted,
    required Function(ChatModel) onChanged,
    required Function(AppException) onError,
    required VoidCallback onFetched,
  }) async {
    final List<QueryModel> queries = [
      QueryModel(
        field: "participantUids",
        value: user.uid,
        type: QueryType.arrayContains,
      ),
      QueryModel(
        field: "lastMessage.messageTime",
        value: true,
        type: QueryType.orderBy,
      ),
      QueryModel(field: "", value: 20, type: QueryType.limit),
    ];

    await FirestoreService().fetchWithListener(
        collection: FIREBASE_COLLECTION_CHAT,
        onError: (e) {
          log("[debug FetchChats] $e");
          onError(throwAppException(e: e));
        },
        onAdded: (data) {
          final chat = ChatModel.fromMap(data);
          onAdded(chat);
        },
        onRemoved: (data) {
          final chat = ChatModel.fromMap(data);
          onDeleted(chat);
        },
        onUpdated: (data) {
          final chat = ChatModel.fromMap(data);
          onChanged(chat);
        },
        onAllDataGet: () {
          onFetched();
        },
        onCompleted: (l) {},
        queries: queries);
  }

  Future<void> addMembers(
      {required String chatId, required List<UserProfileModel> users}) async {
    try {
      await FirestoreService().updateWithDocId(
        path: FIREBASE_COLLECTION_CHAT,
        docId: chatId,
        data: {
          "participantUids":
              FieldValue.arrayUnion(users.map((e) => e.uid).toList()),
          "participants":
              FieldValue.arrayUnion(users.map((e) => e.toMap()).toList()),
        },
      );
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

  Future<void> removeMember(
      {required String chatId, required UserProfileModel member}) async {
    try {
      await FirestoreService().updateWithDocId(
        path: FIREBASE_COLLECTION_CHAT,
        docId: chatId,
        data: {
          "participantUids": FieldValue.arrayRemove([member.uid]),
          "participants": FieldValue.arrayRemove(
            [member.toMap()],
          ),
        },
      );
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

  Future<void> update({
    String? title,
    String? avatar,
    int? totoalMemebrs,
    String? description,
    required String chatId,
  }) async {
    try {
      await CheckVaidation.chat(max: totoalMemebrs ?? 0, name: title);

      if (avatar != null && Uri.parse(avatar).host.isEmpty) {
        avatar = await StorageService().uploadImage(
          withFile: File(avatar),
          collectionPath:
              "$FIREBASE_COLLECTION_CHAT/${DateTime.now().millisecondsSinceEpoch}",
        );
      }

      await FirestoreService().updateWithDocId(
        path: FIREBASE_COLLECTION_CHAT,
        data: {
          "title": title,
          "avatar": avatar,
          "maxMemebrs": totoalMemebrs,
          "description": description,
        },
        docId: chatId,
      );
    } catch (e) {
      log("[debug CreateChat] $e");
      throw throwAppException(e: e);
    }
  }

  /// Create Chat Method
  Future<ChatModel> createChat({
    String? title,
    String? avatar,
    int? totoalMemebrs,
    String? description,
  }) async {
    try {
      await CheckVaidation.chat(max: totoalMemebrs ?? 0, name: title);
      final List<UserProfileModel> participants = [];
      final List<String> participantIds = [];
      if (avatar != null && Uri.parse(avatar).host.isEmpty) {
        avatar = await StorageService().uploadImage(
          withFile: File(avatar),
          collectionPath:
              "$FIREBASE_COLLECTION_CHAT/${DateTime.now().millisecondsSinceEpoch}",
        );
      }
      // Current User Info
      participantIds.add(user.uid);
      participants.add(
        UserProfileModel(
          uid: user.uid,
          name: user.name,
          avatarUrl: user.avatar,
          about: "",
          createdAt: DateTime.now(),
        ),
      );

      final ChatModel chatModel = ChatModel(
        uuid: "",
        createdAt: DateTime.now(),
        createdBy: user.uid,
        participants: participants,
        participantUids: participantIds,
        maxMemebrs: totoalMemebrs ?? 0,
        avatar: avatar,
        description: description,
        title: title!,
        lastMessage: MessageModel(
          messageId: "",
          conversationId: "",
          content: "",
          messageTime: DateTime.now(),
          type: MessageType.text,
          senderId: "",
          senderName: "",
          senderAvatar: "",
        ),
      );

      final Map<String, dynamic> map =
          await FirestoreService().saveWithSpecificIdFiled(
        path: FIREBASE_COLLECTION_CHAT,
        data: chatModel.toMap(),
        docIdFiled: "uuid",
      );
      return ChatModel.fromMap(map);
    } catch (e) {
      log("[debug CreateChat] $e");
      throw throwAppException(e: e);
    }
  }
}
