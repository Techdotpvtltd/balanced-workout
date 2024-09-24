// Project: 	   balanced_workout
// File:    	   edit_profile_screen
// Path:    	   lib/screens/main/user/settings/edit_profile_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 12:57:45 -- Thursday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/app_manager.dart';
import '../../../../blocs/user/user_bloc.dart';
import '../../../../blocs/user/user_event.dart';
import '../../../../blocs/user/user_state.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/dialogs/dialogs.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';
import '../../../components/my_image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserModel user = AppManager().user;
  String? selectedImage;
  int? errorCode;
  String? errorMessage;
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void showImagePicker() {
    final MyImagePicker imagePicker = MyImagePicker();
    imagePicker.pick();
    imagePicker.onSelection(
      (exception, data) {
        if (data is XFile) {
          setState(() {
            selectedImage = data.path;
          });
        }
      },
    );
  }

  void triggerUpdateUserProfileEvent(UserBloc bloc) {
    if (nameController.text == "" || emailController.text == "") {
      setState(() {
        errorCode = nameController.text == "" ? 1 : 2;
        errorMessage =
            nameController.text == "" ? "Enter Your name" : "Enter Your mail.";
      });
      return;
    }

    bloc.add(
      UserEventUpdateProfile(
        avatar: selectedImage,
        name: nameController.text,
        email: emailController.text,
      ),
    );
  }

  @override
  void initState() {
    nameController.text = user.name;
    emailController.text = user.email;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserStateProfileUpdating ||
            state is UserStateProfileUpdated ||
            state is UserStateProfileUpdatingFailure ||
            state is UserStateAvatarUploading ||
            state is UserStateAvatarUploaded ||
            state is UserStatAvatareUploadingFailure) {
          setState(() {
            isLoading = state.isLoading;
            errorCode = null;
          });

          if (state is UserStateProfileUpdatingFailure) {
            if (state.exception.errorCode != null) {
              setState(() {
                errorCode = errorCode;
                errorMessage = errorMessage;
              });

              return;
            }
            CustomDialogs().errorBox(message: state.exception.message);
          }

          if (state is UserStateProfileUpdated) {
            setState(() {
              user = state.user;
            });
            CustomDialogs().successBox(
              message: "Profile updated successfully.",
            );
          }
        }
      },
      child: CustomScaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: HorizontalPadding(
          child: CustomButton(
            onPressed: () {
              triggerUpdateUserProfileEvent(context.read<UserBloc>());
            },
            title: "Save",
            isLoading: isLoading,
          ),
        ),
        appBar: customAppBar(title: "Edit Profile"),
        body: CustomPadding(
          top: 68,
          child: Column(
            children: [
              /// Profile Widget
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 105,
                  width: 105,
                  child: Stack(
                    children: [
                      Positioned(
                        child: AvatarWidget(
                          placeholderChar: user.name.characters.firstOrNull,
                          avatarUrl: selectedImage ?? user.avatar,
                          backgroundColor: Colors.black,
                          width: 100,
                          height: 100,
                        ),
                      ),

                      /// Camera Icon
                      Positioned(
                        right: 0,
                        bottom: 20,
                        child: SizedBox(
                          width: 25,
                          height: 25,
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

              gapH50,

              /// Name Text Field
              CustomTextField(
                controller: nameController,
                errorCode: errorCode,
                errorText: errorMessage,
                fieldId: 01,
                titleText: "Name:",
                hintText: "Enter Your Name",
              ),
              gapH24,

              /// Name Text Field
              CustomTextField(
                errorCode: errorCode,
                errorText: errorMessage,
                fieldId: 02,
                controller: emailController.text == "" ? emailController : null,
                titleText: "Email:",
                isReadyOnly: emailController.text != "",
                hintText: user.email == "" ? "Add Email" : user.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
