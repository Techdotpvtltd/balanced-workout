// Project: 	   balanced_workout
// File:    	   community_info_screen
// Path:    	   lib/screens/main/user/community/community_info_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 16:08:51 -- Thursday
// Description:

import 'package:balanced_workout/blocs/chat/%20chat_bloc.dart';
import 'package:balanced_workout/blocs/chat/chat_event.dart';
import 'package:balanced_workout/models/chat_model.dart';
import 'package:balanced_workout/screens/components/custom_dropdown.dart';
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
        ],
      ),
    );
  }
}
