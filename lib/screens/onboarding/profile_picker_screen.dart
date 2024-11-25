// Project: 	   balanced_workout
// File:    	   profile_picker_screen
// Path:    	   lib/screens/onboarding/profile_picker_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 18:05:31 -- Saturday
// Description:

import 'package:dotted_box/dotted_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/app_manager.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';
import '../../blocs/user/user_state.dart';
import '../../models/user_model.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/dialogs/dialogs.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/avatar_widget.dart';
import '../components/custom_ink_well.dart';
import '../components/my_image_picker.dart';
import '../main/user/main_user_screen.dart';
import 'components/information_widget.dart';
import 'login_screen.dart';

class ProfilePickerScreen extends StatefulWidget {
  const ProfilePickerScreen({super.key});

  @override
  State<ProfilePickerScreen> createState() => _ProfilePickerScreenState();
}

class _ProfilePickerScreenState extends State<ProfilePickerScreen> {
  String? selectedImage = AppManager().user.avatar;
  bool isLoading = false;

  void triggerUpdateUserProfileEvent(UserBloc bloc) {
    final UserModel user = AppManager().user;

    bloc.add(
      UserEventUpdateProfile(
        avatar: selectedImage,
        gender: user.gender,
        age: user.age,
        weight: user.weight,
        height: user.height,
        goal: user.goal,
        role: user.role,
        activityLevel: user.activityLevel,
      ),
    );
  }

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
          });

          if (state is UserStateProfileUpdatingFailure) {
            CustomDialogs().errorBox(message: state.exception.message);
          }

          if (state is UserStateProfileUpdated) {
            if (AppManager().isSSOAccountCreated) {
              NavigationService.offAll(const MainUserScreen());
              AppManager().isSSOAccountCreated = false;
              return;
            }
            CustomDialogs().successBox(
              message:
                  "We've sent you an email verification link to email. Please verify your email by clicking the link before logging in.",
              positiveTitle: "Go to Login",
              barrierDismissible: false,
              onPositivePressed: () {
                NavigationService.offAll(const LoginScreen());
              },
            );
          }
        }
      },
      child: InformationWidget(
        title: "Profile Picture",
        subTitle: "Please add your profile picture",
        middleWidget: CustomInkWell(
          onTap: () {
            showImagePicker();
          },
          child: DottedBox(
            width: 145,
            height: 145,
            borderColor: AppTheme.primaryColor1,
            borderThickness: 2,
            dashCounts: 30,
            borderShape: Shape.circle,
            child: selectedImage != null && selectedImage != ""
                ? AvatarWidget(
                    backgroundColor: Colors.transparent,
                    placeholderChar: "",
                    avatarUrl: selectedImage,
                  )
                : SvgPicture.asset(AppAssets.uploadIcon),
          ),
        ),
        onPressedNext: () {
          triggerUpdateUserProfileEvent(context.read<UserBloc>());
        },
        rightButtonTitle: "Start",
        isLoading: isLoading,
      ),
    );
  }
}
