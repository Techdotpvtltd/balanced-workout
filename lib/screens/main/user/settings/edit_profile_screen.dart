// Project: 	   balanced_workout
// File:    	   edit_profile_screen
// Path:    	   lib/screens/main/user/settings/edit_profile_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 12:57:45 -- Thursday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../components/custom_title_textfiled.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HorizontalPadding(
        child: CustomButton(
          onPressed: () {},
          title: "Save",
        ),
      ),
      appBar: customAppBar(
        title: "Edit Profile",
      ),
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
                    const Positioned(
                      child: AvatarWidget(
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
                          onPressed: () {},
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
            const CustomTextField(
              titleText: "Name:",
              hintText: "Ali Akbar",
            ),
            gapH24,

            /// Name Text Field
            const CustomTextField(
              titleText: "Email:",
              hintText: "abc@gmail.com",
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
