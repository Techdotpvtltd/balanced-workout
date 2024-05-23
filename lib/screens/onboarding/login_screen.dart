// Project: 	   balanced_workout
// File:    	   login_screen
// Path:    	   lib/screens/onboarding/login_screen.dart
// Author:       Ali Akbar
// Date:        03-05-24 20:23:58 -- Friday
// Description:

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import '../../utils/dialogs/dialogs.dart';
import '../../utils/dialogs/loaders.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_button.dart';
import '../components/custom_paddings.dart';
import '../components/custom_scaffold.dart';
import '../components/custom_title_textfiled.dart';
import '../components/social_icon_button.dart';
import '../main/user/main_user_screen.dart';
import 'forgot_screen.dart';
import 'gender_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  int? errorCode;
  String? errorMessage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void triggerLoginEvent(AuthBloc bloc) {
    bloc.add(
      AuthEventPerformLogin(
          email: emailController.text, password: passwordController.text),
    );
  }

  void triggeEmailVerificationMail(AuthBloc bloc) {
    bloc.add(AuthEventSentEmailVerificationLink());
  }

  void triggerAppleLogin(AuthBloc bloc) {
    bloc.add(AuthEventAppleLogin());
  }

  void triggerGoogleLogin(AuthBloc bloc) {
    bloc.add(AuthEventGoogleLogin());
  }

  void triggerFacebookLogin(AuthBloc bloc) {
    bloc.add(AuthEventFacebookLogin());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLogging ||
            state is AuthStateLoggedIn ||
            state is AuthStateLoginFailure ||
            state is AuthStateEmailVerificationRequired ||
            state is AuthStateAppleLoggedIn ||
            state is AuthStateGoogleLoggedIn ||
            state is AuthStateGoogleLogging ||
            state is AuthStateFacebookLoggedIn ||
            state is AuthStateFacebookLogging ||
            state is AuthStateSendingMailVerification ||
            state is AuthStateSendingMailVerificationFailure ||
            state is AuthStateSentMailVerification ||
            state is AuthStateNeedToGetUserInfo) {
          setState(() {
            errorCode = null;
          });

          /// Start Of Code
          if (state is AuthStateLogging ||
              state is AuthStateLoggedIn ||
              state is AuthStateLoginFailure ||
              state is AuthStateEmailVerificationRequired ||
              state is AuthStateAppleLoggedIn ||
              state is AuthStateGoogleLoggedIn ||
              state is AuthStateGoogleLogging ||
              state is AuthStateFacebookLoggedIn ||
              state is AuthStateFacebookLogging ||
              state is AuthStateNeedToGetUserInfo) {
            setState(() {
              isLoading = state.isLoading;
            });

            if (state is AuthStateLoginFailure) {
              if (state.exception.errorCode != null) {
                setState(() {
                  errorCode = state.exception.errorCode;
                  errorMessage = state.exception.message;
                });
                return;
              }
              CustomDialogs().errorBox(message: state.exception.message);
            }

            if (state is AuthStateNeedToGetUserInfo) {
              NavigationService.off(const GenderScreen());
            }
            if (state is AuthStateLoggedIn ||
                state is AuthStateAppleLoggedIn ||
                state is AuthStateGoogleLoggedIn ||
                state is AuthStateFacebookLoggedIn) {
              NavigationService.off(const MainUserScreen());
            }
          }

          if (state is AuthStateEmailVerificationRequired) {
            CustomDialogs().alertBox(
              message:
                  "Please verify your email by clicking on the link provided in the email we've sent you.",
              title: "Email Verification Required",
              positiveTitle: "Login again",
              negativeTitle: "Sent link agin",
              onPositivePressed: () {
                triggerLoginEvent(context.read<AuthBloc>());
              },
              onNegativePressed: () {
                triggeEmailVerificationMail(context.read<AuthBloc>());
              },
            );
          }
          // For Email Verification States
          if (state is AuthStateSendingMailVerification ||
              state is AuthStateSendingMailVerificationFailure ||
              state is AuthStateSentMailVerification) {
            state.isLoading ? Loader().show() : NavigationService.back();

            if (state is AuthStateSendingMailVerificationFailure) {
              CustomDialogs().errorBox(message: state.exception.message);
            }

            if (state is AuthStateSentMailVerification) {
              CustomDialogs().successBox(
                  message:
                      "We've sent you an email verification link to ${emailController.text}. Please verify your email by clicking the link before logging in.");
            }
          }
        }
      },
      child: CustomScaffold(
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
                  CustomTextField(
                    controller: emailController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 01,
                    hintText: "Email",
                    titleText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: AppAssets.userIcon1,
                  ),
                  gapH24,

                  /// Password Field
                  CustomTextField(
                    controller: passwordController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 02,
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
                    isLoading: isLoading,
                    onPressed: () {
                      triggerLoginEvent(context.read<AuthBloc>());
                    },
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
                      /// FB Login
                      SocialIconButton(
                        icon: AppAssets.facebookIcon,
                        onPressed: () {
                          triggerFacebookLogin(context.read<AuthBloc>());
                        },
                      ),
                      gapW28,
                      /// Apple Login
                      if (Platform.isIOS)
                        SocialIconButton(
                          icon: AppAssets.appleIcon,
                          onPressed: () {
                            triggerAppleLogin(context.read<AuthBloc>());
                          },
                          backgroundColor: const Color(0xFF3A3A3C),
                        ),
                      if (Platform.isIOS) gapW28,

                      /// Google Login
                      SocialIconButton(
                        icon: AppAssets.googleIcon,
                        onPressed: () {
                          triggerGoogleLogin(context.read<AuthBloc>());
                        },
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
      ),
    );
  }
}
