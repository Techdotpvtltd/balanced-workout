// Project: 	   balanced_workout
// File:    	   create_community_screen
// Path:    	   lib/screens/main/user/community/create_community_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 15:50:22 -- Thursday
// Description:

import 'package:balanced_workout/blocs/chat/%20chat_bloc.dart';
import 'package:balanced_workout/blocs/chat/chat_event.dart';
import 'package:balanced_workout/blocs/chat/chat_state.dart';
import 'package:balanced_workout/screens/components/custom_network_image.dart';
import 'package:balanced_workout/utils/dialogs/dialogs.dart';
import 'package:balanced_workout/utils/extensions/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';
import '../../../components/my_image_picker.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  String? avatar;

  bool isLoading = false;

  void triggerCreateCommunityEvent() {
    context.read<ChatBloc>().add(ChatEventCreate(
        title: nameController.text,
        maxMembers: int.tryParse(maxController.text) ?? 0,
        avatar: avatar,
        description: descriptionController.text));
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatStateCreated ||
            state is ChatStateCreating ||
            state is ChatStateCreateFailure) {
          setState(() {
            isLoading = state.isLoading;
          });

          if (state is ChatStateCreated) {
            NavigationService.back();
          }

          if (state is ChatStateCreateFailure) {
            CustomDialogs().errorBox(message: state.exception.message);
          }
        }
      },
      child: CustomScaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: HorizontalPadding(
          child: CustomButton(
            isLoading: isLoading,
            onPressed: () {
              triggerCreateCommunityEvent();
            },
            title: 'Create',
          ),
        ),
        appBar: customAppBar(
          title: 'Create Community',
        ),
        body: ListView(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 46, bottom: 100),
          physics: const ScrollPhysics(),
          children: [
            /// Upload Image Button
            CustomContainer(
              onPressed: () {
                showImagePicker();
              },
              size: const Size.fromHeight(183),
              color: AppTheme.darkWidgetColor2,
              borderRadius: const BorderRadius.all(Radius.circular(21)),
              child: avatar != null
                  ? CustomNetworkImage(imageUrl: avatar ?? "")
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 40,
                          color: AppTheme.primaryColor1,
                        ),
                        gapH6,
                        Text(
                          'Upload Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
      ),
    );
  }
}
