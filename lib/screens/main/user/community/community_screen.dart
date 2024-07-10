// Project: 	   balanced_workout
// File:    	   community_screen
// Path:    	   lib/screens/main/user/community/community_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 14:41:26 -- Thursday
// Description:

import 'package:balanced_workout/blocs/chat/%20chat_bloc.dart';
import 'package:balanced_workout/blocs/chat/chat_event.dart';
import 'package:balanced_workout/blocs/chat/chat_state.dart';
import 'package:balanced_workout/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/chat_model.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';
import 'create_community_screen.dart';
import 'group_chat_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<ChatModel> chats = [];
  bool isLoading = false;

  void triggerFetchChatsEvent() {
    context.read<ChatBloc>().add(ChatEventFetchAll());
  }

  @override
  void initState() {
    triggerFetchChatsEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatStateFetching ||
            state is ChatStateUpdates ||
            state is ChatStateFetchFailure) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is ChatStateUpdates) {
            setState(() {
              chats = state.chats;
            });
          }

          if (state is ChatStateFetchFailure) {
            debugPrint(state.exception.message);
          }
        }
      },
      child: CustomScaffold(
        floatingActionButton: CircleButton(
          onPressed: () {
            NavigationService.go(const CreateCommunityScreen());
          },
          icon: AppAssets.plusIcon,
          backgroundColor: AppTheme.primaryColor1,
        ),
        appBar: customAppBar(title: "Community"),
        body: CustomPadding(
          top: 30,
          child: Column(
            children: [
              /// Search Text
              const CustomTextField(
                hintText: "Search",
                prefixWidget: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),

              /// Community Widget
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 15, bottom: 70),
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final ChatModel chat = chats[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: CustomContainer(
                              onPressed: () {
                                NavigationService.go(
                                  GroupChatScreen(
                                    chat: chats[index],
                                  ),
                                );
                              },
                              padding: const EdgeInsets.only(
                                  left: 17, top: 16, bottom: 16, right: 20),
                              color: const Color(0xFFF2F2F2).withOpacity(0.12),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AvatarWidget(
                                    avatarUrl: chat.avatar ?? "",
                                    backgroundColor: Colors.brown,
                                    placeholderChar:
                                        chat.title.characters.firstOrNull ?? "",
                                    width: 32,
                                    height: 32,
                                  ),
                                  gapW10,

                                  /// Community Description
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                chat.title,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            gapW10,
                                            Flexible(
                                              child: Text(
                                                (chat.lastMessage
                                                            ?.messageTime ??
                                                        DateTime.now())
                                                    .dateToString(
                                                  "dd MMM yyyy hh:mm a",
                                                ),
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// Description and Join Button Feature
                                        gapH2,
                                        Text(
                                          chat.lastMessage?.content == ""
                                              ? (chat.description ?? "")
                                              : (chat.lastMessage?.content ??
                                                  ""),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
