// Project: 	   balanced_workout
// File:    	   setting_screen
// Path:    	   lib/screens/main/user/setting_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 11:04:48 -- Thursday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/avatar_widget.dart';
import '../../components/circle_button.dart';
import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_child_button.dart';
import '../../components/custom_container.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_scaffold.dart';
import '../../onboarding/forgot_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomPadding(
        bottom: 70,
        child: CustomButton(
          onPressed: () {},
          title: "Logout",
        ),
      ),
      appBar: customAppBar(
        topPadding: 60,
        title: "Settings",
        showBack: false,
        leftPadding: 29,
        rightPadding: 29,
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 35, left: 29, right: 29, bottom: 180),
        physics: const ScrollPhysics(),
        children: [
          CustomContainer(
            color: AppTheme.primaryColor1,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// AvatarWidget
                const Row(
                  children: [
                    AvatarWidget(
                      avatarUrl: "",
                      backgroundColor: Colors.black,
                      width: 79,
                      height: 79,
                    ),
                    gapW12,

                    /// Text Widgets
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ali Akbar",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppTheme.titleDarkColor1,
                          ),
                        ),
                        Text(
                          "abc@gmai.com",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppTheme.titleDarkColor1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Edit Button
                CircleButton(
                  onPressed: () {},
                  icon: AppAssets.editIcon,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),

          /// Change Password Button
          gapH20,
          CustomChildButton(
            onPressed: () {
              NavigationService.go(const ForgotPasswordScreen());
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.lockIcon,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                gapW30,
                Text(
                  "Change Password",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// Contact Us Button
          gapH10,
          CustomChildButton(
            onPressed: () {},
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.infoIcon,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                gapW30,
                Text(
                  "Contact Us",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// Subscription Button
          gapH10,
          CustomChildButton(
            onPressed: () {},
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.subscriptionIcon,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                gapW30,
                Text(
                  "Subscription",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// Invite Button
          gapH10,
          CustomChildButton(
            onPressed: () {},
            child: Text(
              "Invite Friend",
              style: GoogleFonts.poppins(
                color: AppTheme.primaryColor1,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
