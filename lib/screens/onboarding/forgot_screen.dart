// Project: 	   balanced_workout
// File:    	   forgot_screen
// Path:    	   lib/screens/onboarding/forgot_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 13:16:11 -- Saturday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../components/custom_paddings.dart';
import '../components/custom_scaffold.dart';
import '../components/custom_title_textfiled.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          width: SCREEN_WIDTH,
          height: SCREEN_HEIGHT,
          child: CustomPadding(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Text
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gapH8,
                // Description
                const Text(
                  "Enter your information below or login with a other account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.titleColor3,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SCREEN_HEIGHT * 0.07),

                /// Icon Widget
                SvgPicture.asset(AppAssets.lockBackgroundIcon),
                SizedBox(height: SCREEN_HEIGHT * 0.04),
                const CustomTextField(
                  titleText: "Email",
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: AppAssets.userIcon1,
                ),
                SizedBox(height: SCREEN_HEIGHT * 0.16),

                /// Send Button
                CustomButton(
                  onPressed: () {},
                  title: "Send",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
