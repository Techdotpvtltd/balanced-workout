// Project: 	   balanced_workout
// File:    	   forgot_screen
// Path:    	   lib/screens/onboarding/forgot_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 13:16:11 -- Saturday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import '../../utils/dialogs/dialogs.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_button.dart';
import '../components/custom_paddings.dart';
import '../components/custom_scaffold.dart';
import '../components/custom_title_textfiled.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  int? errorCode;
  String? errorMessage;

  void triggerForgotPassword(AuthBloc bloc) {
    bloc.add(
      AuthEventForgotPassword(email: emailController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSendingForgotEmail ||
            state is AuthStateSendForgotEmailFailure ||
            state is AuthStateSentForgotEmail) {
          setState(() {
            isLoading = state.isLoading;
            errorCode = null;
          });

          if (state is AuthStateSendForgotEmailFailure) {
            if (state.exception.errorCode != null) {
              setState(() {
                errorCode = state.exception.errorCode;
                errorMessage = state.exception.message;
              });
              return;
            }
            CustomDialogs().errorBox(message: state.exception.message);
          }

          if (state is AuthStateSentForgotEmail) {
            CustomDialogs().successBox(
              message:
                  "We've just sent you an email containing a password reset link.\nPlease check your mail.",
              title: "Mail Sent!",
              positiveTitle: "Go back",
              onPositivePressed: () {
                NavigationService.back();
              },
            );
          }
        }
      },
      child: CustomScaffold(
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
                  CustomTextField(
                    controller: emailController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 01,
                    titleText: "Email",
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: AppAssets.userIcon1,
                  ),
                  SizedBox(height: SCREEN_HEIGHT * 0.16),

                  /// Send Button
                  CustomButton(
                    isLoading: isLoading,
                    onPressed: () {
                      triggerForgotPassword(context.read<AuthBloc>());
                    },
                    title: "Send",
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
