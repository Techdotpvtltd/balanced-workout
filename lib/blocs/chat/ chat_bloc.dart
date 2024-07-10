// Project: 	   muutsch
// File:    	    chat_bloc
// Path:    	   lib/blocs/chat/ chat_bloc.dart
// Author:       Ali Akbar
// Date:        31-05-24 13:44:34 -- Friday
// Description:

// ignore_for_file: file_names

import 'package:balanced_workout/exceptions/data_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/app_exceptions.dart';
import '../../models/chat_model.dart';
import '../../repos/chat_repo.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatModel> chats = [];

  ChatBloc() : super(ChatStateInitial()) {
    /// Fetch Single Chat Evenst
    on<ChatEventFetchAll>(
      (event, emit) async {
        emit(ChatStateFetching());
        await ChatRepo().fetchChats(
          onFetched: () {
            emit(ChatStateUpdates(chats: chats));
          },
          onAdded: (chat) {
            if (chats.where((e) => e.uuid == chat.uuid).isEmpty) {
              chats.add(chat);
            }
            emit(ChatStateUpdates(chats: chats));
          },
          onDeleted: (chat) {
            final int index = chats.indexWhere((e) => e.uuid == chat.uuid);
            if (index > -1) {
              chats.removeAt(index);
            }
            emit(ChatStateUpdates(chats: chats));
          },
          onChanged: (chat) {
            final int index = chats.indexWhere((e) => e.uuid == chat.uuid);
            if (index > -1) {
              chats[index] = chat;
            }
            emit(ChatStateUpdates(chats: chats));
          },
          onError: (e) {
            emit(ChatStateFetchFailure(exception: e));
          },
        );
      },
    );

    /// Create Chat Event
    on<ChatEventCreate>(
      (event, emit) async {
        try {
          emit(ChatStateCreating());
          final ChatModel chat = await ChatRepo().createChat(
            title: event.title,
            avatar: event.avatar,
            totoalMemebrs: event.maxMembers,
            description: event.description,
          );
          emit(ChatStateCreated(chat: chat));
        } on AppException catch (e) {
          emit(ChatStateCreateFailure(exception: e));
        }
      },
    );

    on<ChatEventUpdate>(
      (event, emit) async {
        try {
          emit(ChatStateUpdating());
          await ChatRepo().update(
              chatId: event.chatId,
              title: event.title,
              avatar: event.avatar,
              description: event.description,
              totoalMemebrs: event.maxMembers);
          final int index = chats.indexWhere((e) => e.uuid == e.uuid);
          if (index > -1) {
            emit(ChatStateeUpdated(chat: chats[index]));
          } else {
            emit(ChatStateeUpdateFailure(exception: DataExceptionNotFound()));
          }
        } on AppException catch (e) {
          emit(ChatStateeUpdateFailure(exception: e));
        }
      },
    );

    /// Join Group Chat
    on<ChatEventAddMembers>(
      (event, emit) async {
        try {
          emit(ChatStateAddingMembers());
          await ChatRepo().addMembers(chatId: event.chatId, users: event.users);
          emit(ChatStateAddedMembers());
        } on AppException catch (e) {
          emit(ChatStateAddMemberFailure(exception: e));
        }
      },
    );

    /// Remove Member Chat
    on<ChatEventRemoveMember>(
      (event, emit) async {
        ChatRepo().removeMember(chatId: event.chatId, member: event.member);
        emit(ChatStateMemberRemoved(memeberId: event.member.uid));
      },
    );
  }
}
