// Project: 	   balanced_workout
// File:    	   add_member_screens
// Path:    	   lib/screens/main/user/community/add_member_screens.dart
// Author:       Ali Akbar
// Date:        09-05-24 16:51:01 -- Thursday
// Description:

import 'package:balanced_workout/blocs/chat/%20chat_bloc.dart';
import 'package:balanced_workout/blocs/chat/chat_event.dart';
import 'package:balanced_workout/blocs/chat/chat_state.dart';
import 'package:balanced_workout/blocs/user/user_bloc.dart';
import 'package:balanced_workout/blocs/user/user_event.dart';
import 'package:balanced_workout/blocs/user/user_state.dart';
import 'package:balanced_workout/models/chat_model.dart';
import 'package:balanced_workout/models/user_profile_model.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key, required this.chat});
  final ChatModel chat;
  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  List<UserModel> searchedUsers = [];
  late List<UserProfileModel> addedUsers = [];
  bool isSearching = false;
  bool isAdding = false;

  void triggerAddMemberEvent() {
    context
        .read<ChatBloc>()
        .add(ChatEventAddMembers(users: addedUsers, chatId: widget.chat.uuid));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// UserBloc
        BlocListener<UserBloc, UserState>(
          listener: (ctx, state) {
            if (state is UserStateSearchFetchFailure ||
                state is UserStateSearchFetched ||
                state is UserStateSearchFetching) {
              setState(() {
                isSearching = state.isLoading;
              });

              if (state is UserStateSearchFetched) {
                setState(() {
                  searchedUsers = state.users;
                });
              }

              if (state is UserStateSearchFetchFailure) {
                debugPrint(state.exception.message);
              }
            }
          },
        ),

        /// ChatBloc
        BlocListener<ChatBloc, ChatState>(
          listener: (ctx, state) {
            if (state is ChatStateAddedMembers ||
                state is ChatStateAddingMembers ||
                state is ChatStateAddMemberFailure) {
              setState(() {
                isAdding = state.isLoading;
              });

              if (state is ChatStateAddingMembers) {
                NavigationService.back();
              }
            }
          },
        ),
      ],
      child: CustomScaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: HorizontalPadding(
          child: Visibility(
            visible: addedUsers.isNotEmpty,
            child: CustomButton(
              isLoading: isAdding,
              onPressed: () {
                triggerAddMemberEvent();
              },
              title: 'Add ${addedUsers.length > 1 ? "Users" : "User"}',
            ),
          ),
        ),
        appBar: customAppBar(
          title: "Add Members",
        ),
        body: CustomPadding(
          child: Column(
            children: [
              /// Search TF
              CustomTextField(
                hintText: 'Search',
                prefixWidget: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (text) {
                  final ignoreIds = widget.chat.participantUids;
                  ignoreIds.addAll(addedUsers.map((e) => e.uid).toList());
                  context.read<UserBloc>().add(
                        UserEventSearchUsers(
                          search: text,
                          ignoreIds: ignoreIds,
                        ),
                      );
                },
              ),

              /// Profile List View
              Expanded(
                child: isSearching
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: searchedUsers.length,
                        padding: const EdgeInsets.only(top: 22, bottom: 80),
                        itemBuilder: (context, index) {
                          final UserModel user = searchedUsers[index];
                          late final bool isSelected = addedUsers
                              .where((e) => e.uid == user.uid)
                              .isNotEmpty;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: CustomContainer(
                              onPressed: () {
                                final int index = addedUsers
                                    .indexWhere((e) => e.uid == user.uid);
                                setState(() {
                                  if (index > -1) {
                                    addedUsers.removeAt(index);
                                  } else {
                                    addedUsers.add(UserProfileModel(
                                        uid: user.uid,
                                        name: user.name,
                                        avatarUrl: user.avatar,
                                        createdAt: DateTime.now()));
                                  }
                                });
                              },
                              color: const Color(0xFF232323)
                                  .withValues(alpha: 0.62),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 9,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// Custom Avatar
                                  Expanded(
                                    child: Row(
                                      children: [
                                        AvatarWidget(
                                          width: 41,
                                          height: 41,
                                          backgroundColor: Colors.black,
                                          avatarUrl: user.avatar,
                                        ),
                                        gapW10,

                                        /// Name Text
                                        Flexible(
                                          child: Text(
                                            user.name,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (value) {},
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(300)),
                                    ),
                                    fillColor: const WidgetStatePropertyAll(
                                        Colors.transparent),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    side: WidgetStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          color: !isSelected
                                              ? const Color(0xFF434242)
                                              : AppTheme.primaryColor1),
                                    ),
                                    checkColor: AppTheme.primaryColor1,
                                    visualDensity: VisualDensity.comfortable,
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
