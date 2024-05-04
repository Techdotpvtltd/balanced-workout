// Project: 	   balanced_workout
// File:    	   login_screen
// Path:    	   lib/screens/onboarding/login_screen.dart
// Author:       Ali Akbar
// Date:        03-05-24 20:23:58 -- Friday
// Description:

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_button.dart';
import '../components/custom_paddings.dart';
import '../components/custom_scaffold.dart';
import '../components/custom_title_textfiled.dart';
import '../components/social_icon_button.dart';
import 'forgot_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImagePath: AppAssets.authBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: CustomPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo
                Image.asset(
                  AppAssets.logo,
                  width: 62,
                  height: 62,
                ),
                gapH30,

                /// Welcome Text
                const Text.rich(
                  TextSpan(
                    text: "Welcome to\n",
                    style: TextStyle(
                      color: AppTheme.titleColor1,
                      fontSize: 32,
                    ),
                    children: [
                      TextSpan(
                        text: "Balanced workout",
                        style: TextStyle(
                          color: AppTheme.primaryColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                gapH50,

                /// Email TextFiled
                const CustomTextField(
                  hintText: "Email",
                  titleText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: AppAssets.userIcon1,
                ),
                gapH24,

                /// Password Field
                const CustomTextField(
                  hintText: "Password",
                  titleText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: AppAssets.lockIcon,
                ),

                /// ForgotPassword
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      NavigationService.go(const ForgotPasswordScreen());
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppTheme.primaryColor1,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                gapH50,

                /// Login Button
                CustomButton(
                  onPressed: () {},
                  title: "Login",
                ),

                /// OR Widget
                gapH50,
                gapH16,
                const HorizontalPadding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 1,
                          thickness: 0.25,
                        ),
                      ),
                      gapW36,
                      Text(
                        "or login with",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      gapW36,
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 1,
                          thickness: 0.25,
                        ),
                      ),
                    ],
                  ),
                ),
                gapH36,

                /// Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIconButton(
                      icon: AppAssets.appleIcon,
                      onPressed: () {},
                      backgroundColor: const Color(0xFF3A3A3C),
                    ),
                    gapW28,
                    SocialIconButton(
                      icon: AppAssets.googleIcon,
                      onPressed: () {},
                    ),
                  ],
                ),
                gapH26,

                /// Don't have account texts
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFFADB1B7),
                    ),
                    TextSpan(
                      text: "Don’t have an account? ",
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavigationService.offAll(const SignUpScreen());
                            },
                          style: const TextStyle(
                            color: AppTheme.primaryColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
