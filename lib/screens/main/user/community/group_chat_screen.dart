// Project: 	   balanced_workout
// File:    	   group_chat_screen
// Path:    	   lib/screens/main/user/community/group_chat_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 17:49:06 -- Thursday
// Description:

import 'package:balanced_workout/models/chat_model.dart';
import 'package:balanced_workout/screens/main/user/community/bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../blocs/message/mesaage_bloc.dart';
import '../../../../blocs/message/message_event.dart';
import '../../../../models/message_model.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_ink_well.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';
import '../../../components/my_image_picker.dart';
import 'community_info_screen.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key, required this.chat});
  final ChatModel chat;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  late final ChatModel chat = widget.chat;
  TextEditingController messageController = TextEditingController();

  void triggerSenderMediaMessageEvent(
      {required String fileUrl, required String contentType}) {
    context.read<MessageBloc>().add(MessageEventSend(
        content: fileUrl,
        type: MessageType.photo,
        conversationId: widget.chat.uuid,
        friendId: ""));
  }

  void onMediaPressed() {
    final MyImagePicker imagePicker = MyImagePicker();
    imagePicker.pick();
    imagePicker.onSelection((exception, data) {
      if (data is XFile) {
        triggerSenderMediaMessageEvent(
            fileUrl: data.path, contentType: "image/jpeg");
      }
    });
  }

  void triggerSenderMessageEvent() {
    context.read<MessageBloc>().add(
          MessageEventSend(
            content: messageController.text,
            type: MessageType.text,
            conversationId: widget.chat.uuid,
            friendId: "",
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(
        background: const Color(0xFF2C2C2E).withOpacity(0.62),

        /// Title Widget
        titleWidget: CustomInkWell(
          onTap: () {
            NavigationService.go(
              CommunityInfoScreen(chat: chat),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              gapH6,
              Text.rich(
                TextSpan(
                  text: chat.participantUids.length.toString(),
                  children: const [
                    TextSpan(
                      text: ' members',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        /// Menu Button
        actions: [
          // CircleButton(
          //   icon: AppAssets.menuIcon,
          //   onPressed: () {},
          //   backgroundColor: const Color(0xFFDEDEE0).withOpacity(0.11),
          // ),
          gapW20,
        ],
      ),
      body: Column(
        children: [
          /// A chapi Style
          Container(
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E).withOpacity(0.62),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          Expanded(
            child: BubbleWidget(conversationId: chat.uuid),
          ),

          /// TextField
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
            child: CustomTextField(
              controller: messageController,
              hintText: "Message",
              maxLines: 5,
              minLines: 1,
              prefixWidget: SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: CircleButton(
                    onPressed: () {
                      onMediaPressed();
                    },
                    icon: AppAssets.plusIcon,
                    backgroundColor: AppTheme.primaryColor1,
                  ),
                ),
              ),
              suffixWidget: CustomInkWell(
                onTap: () {
                  triggerSenderMessageEvent();
                  messageController.clear();
                },
                child: const Icon(
                  Icons.send,
                  color: AppTheme.primaryColor1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
