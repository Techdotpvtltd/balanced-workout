// Project: 	   balanced_workout
// File:    	   chat_widget
// Path:    	   lib/screens/components/chat_widget.dart
// Author:       Ali Akbar
// Date:        10-05-24 13:46:20 -- Friday
// Description:

import 'package:balanced_workout/models/chat_model.dart';
import 'package:flutter/material.dart';

import '../../app/app_manager.dart';
import '../../models/message_model.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';

import '../../utils/extensions/helping_methods.dart';
import '../../utils/extensions/navigation_service.dart';
import '../main/user/community/group_chat_screen.dart';
import 'avatar_widget.dart';
import 'custom_container.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.chat});
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.only(left: 14, right: 11, top: 12, bottom: 20),
      color: const Color(0xFF2B2B2B).withOpacity(0.68),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onPressed: () {
        NavigationService.go(
          GroupChatScreen(chat: chat),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// Time Label
          Text(
            formatChatDateToString(chat.lastMessage?.messageTime) ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 9,
              color: AppTheme.primaryColor1,
            ),
          ),
          gapH4,
          // Profile
          Row(
            children: [
              AvatarWidget(
                width: 33,
                height: 33,
                backgroundColor: Colors.black,
                placeholderChar: chat.title.characters.firstOrNull ?? "",
                avatarUrl: chat.avatar,
              ),
              gapW10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name Label
                    Text(
                      chat.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),

                    gapH4,

                    /// Name Label
                    Text(
                      chat.lastMessage?.type == MessageType.text
                          ? "${chat.lastMessage?.senderId == AppManager().user.uid ? "You: ${chat.lastMessage?.content}" : chat.lastMessage?.content}"
                          : chat.lastMessage?.senderId == AppManager().user.uid
                              ? "You sent Photo"
                              : "Recieved Photo",
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
