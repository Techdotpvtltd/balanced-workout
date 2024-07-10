// Project: 	   balanced_workout
// File:    	   community_info_screen
// Path:    	   lib/screens/main/user/community/community_info_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 16:08:51 -- Thursday
// Description:

import 'package:balanced_workout/app/app_manager.dart';
import 'package:balanced_workout/blocs/chat/%20chat_bloc.dart';
import 'package:balanced_workout/blocs/chat/chat_event.dart';
import 'package:balanced_workout/models/chat_model.dart';
import 'package:balanced_workout/models/user_model.dart';
import 'package:balanced_workout/screens/components/custom_container.dart';
import 'package:balanced_workout/screens/components/custom_dropdown.dart';
import 'package:balanced_workout/screens/main/user/community/add_member_screens.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';
import '../../../components/my_image_picker.dart';

class CommunityInfoScreen extends StatefulWidget {
  const CommunityInfoScreen({super.key, required this.chat});
  final ChatModel chat;

  @override
  State<CommunityInfoScreen> createState() => _CommunityInfoScreenState();
}

class _CommunityInfoScreenState extends State<CommunityInfoScreen> {
  late final chat = widget.chat;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  String? avatar;
  final UserModel? user = AppManager().user;
  late final bool isAdmin = user?.uid == chat.createdBy;

  void triggerUpdateProfileEvent() {
    context.read<ChatBloc>().add(
          ChatEventUpdate(
              title: nameController.text,
              chatId: chat.uuid,
              maxMembers: int.tryParse(maxController.text) ?? 0,
              description: descriptionController.text,
              avatar: avatar),
        );
  }

  void showImagePicker() {
    final MyImagePicker imagePicker = MyImagePicker();
    imagePicker.pick();
    imagePicker.onSelection(
      (exception, data) {
        if (data is XFile) {
          setState(() {
            avatar = data.path;
          });
        }
      },
    );
  }

  void setData() {
    nameController.text = chat.title;
    descriptionController.text = chat.description ?? "";
    avatar = chat.avatar;
    maxController.text = chat.maxMemebrs.toString();
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(title: "Community Info", actions: [
        CustomMenuDropdown(
          items: [
            DropdownMenuModel(title: "Save", icon: Icons.save),
          ],
          onSelectedItem: (val, index) {
            if (val == "Save") {
              triggerUpdateProfileEvent();
            }
          },
        )
      ]),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 47, left: 29, right: 29, bottom: 100),
        children: [
          /// Profile Widget
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                children: [
                  Positioned(
                    child: AvatarWidget(
                      backgroundColor: Colors.green,
                      width: 110,
                      height: 110,
                      placeholderChar: chat.title.characters.firstOrNull ?? "B",
                      avatarUrl: avatar ?? "",
                    ),
                  ),

                  /// Camera Icon
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircleButton(
                        onPressed: () {
                          showImagePicker();
                        },
                        icon: AppAssets.cameraIcon,
                        backgroundColor: AppTheme.primaryColor1,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Name
          gapH22,
          CustomTextField(
            controller: nameController,
            titleText: "Name",
            hintText: 'Community Name',
          ),

          /// Description
          gapH22,
          CustomTextField(
            controller: descriptionController,
            titleText: "Description",
            hintText: 'Write Description',
            maxLines: 8,
          ),

          /// Maximum Members
          gapH22,
          CustomTextField(
            controller: maxController,
            titleText: "Max Community Limit",
            hintText: 'Add number of persons can join.',
            keyboardType: TextInputType.number,
          ),

          gapH22,

          /// Members Detail Screen
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${chat.participantUids.length} ${chat.participantUids.length > 1 ? "Members" : "Member"}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isAdmin)
                IconButton(
                  onPressed: () {
                    NavigationService.go(const AddMemberScreen());
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppTheme.primaryColor1,
                  ),
                )
            ],
          ),
          gapH10,
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppTheme.darkWidgetColor2,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                for (int i = 0; i < chat.participants.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CustomContainer(
                      onPressed: () {},
                      color: const Color(0xFF232323).withOpacity(0.62),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Custom Avatar
                          Expanded(
                            child: Row(
                              children: [
                                AvatarWidget(
                                  width: 41,
                                  height: 41,
                                  backgroundColor: Colors.black,
                                  avatarUrl: chat.participants[i].avatarUrl,
                                ),
                                gapW10,

                                /// Name Text
                                Flexible(
                                  child: Text(
                                    chat.participants[i].uid == user?.uid
                                        ? "You"
                                        : chat.participants[i].name,
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

                          // CustomMenuDropdown(
                          //   items: const [],
                          //   onSelectedItem: (val, index) {},
                          // )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
