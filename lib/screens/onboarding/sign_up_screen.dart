// Project: 	   balanced_workout
// File:    	   sign_up_screen
// Path:    	   lib/screens/onboarding/sign_up_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 15:00:27 -- Saturday
// Description:

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
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_button.dart';
import '../components/custom_paddings.dart';
import '../components/custom_scaffold.dart';
import '../components/custom_title_textfiled.dart';
import '../components/social_icon_button.dart';
import '../main/user/main_user_screen.dart';
import 'login_screen.dart';
import 'user_type_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  int? errorCode;
  String? errorMessage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void triggerSignupEvent(AuthBloc bloc) {
    bloc.add(
      AuthEventRegistering(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmController.text,
      ),
    );
  }

  void triggerAppleLogin(AuthBloc bloc) {
    bloc.add(AuthEventAppleLogin());
  }

  void triggerGoogleLogin(AuthBloc bloc) {
    bloc.add(AuthEventGoogleLogin());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateRegisterFailure ||
            state is AuthStateRegistered ||
            state is AuthStateRegistering ||
            state is AuthStateAppleLoggedIn ||
            state is AuthStateGoogleLoggedIn ||
            state is AuthStateLogging ||
            state is AuthStateLoggedIn ||
            state is AuthStateLoginFailure ||
            state is AuthStateGoogleLogging ||
            state is AuthStateNeedToGetUserInfo) {
          setState(() {
            isLoading = state.isLoading;
            errorCode = null;
          });

          if (state is AuthStateRegisterFailure) {
            if (state.exception.errorCode != null) {
              setState(() {
                errorCode = state.exception.errorCode;
                errorMessage = state.exception.message;
              });
              return;
            }

            CustomDialogs().errorBox(message: state.exception.message);
          }

          if (state is AuthStateRegistered ||
              state is AuthStateNeedToGetUserInfo) {
            NavigationService.off(
                const UserTypeScreen(isComingFromSignup: true));
          }

          if (state is AuthStateLoginFailure) {
            if (state.exception.errorCode != null) {
              CustomDialogs().errorBox(message: state.exception.message);
            }
          }

          if (state is AuthStateLoggedIn ||
              state is AuthStateAppleLoggedIn ||
              state is AuthStateGoogleLoggedIn) {
            NavigationService.offAll(const MainUserScreen());
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
                  const Text(
                    "Registration",
                    style: TextStyle(
                      color: AppTheme.primaryColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  gapH50,

                  /// Email TextFiled
                  CustomTextField(
                    controller: nameController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 01,
                    hintText: "Name",
                    titleText: "Name",
                    keyboardType: TextInputType.name,
                    prefixIcon: AppAssets.userIcon1,
                  ),
                  gapH24,

                  /// Email TextFiled
                  CustomTextField(
                    controller: emailController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 02,
                    hintText: "Email",
                    titleText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: AppAssets.emailIcon,
                  ),
                  gapH24,

                  /// Password Field
                  CustomTextField(
                    controller: passwordController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 03,
                    hintText: "Password",
                    titleText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: AppAssets.lockIcon,
                  ),

                  gapH24,

                  /// Confirm Password Field
                  CustomTextField(
                    controller: confirmController,
                    errorCode: errorCode,
                    errorText: errorMessage,
                    fieldId: 04,
                    hintText: "Confirm Password",
                    titleText: "Confirm Password",
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: AppAssets.lockIcon,
                  ),
                  gapH50,

                  /// Login Button
                  CustomButton(
                    onPressed: () {
                      triggerSignupEvent(context.read<AuthBloc>());
                    },
                    isLoading: isLoading,
                    title: isLoading ? "Creating Account..." : "Sign up",
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
                          "or Sign Up with",
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
                        onPressed: () {
                          triggerAppleLogin(context.read<AuthBloc>());
                        },
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
                        text: "Already Have an Account? ",
                        children: [
                          TextSpan(
                            text: "Sign In",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                NavigationService.offAll(const LoginScreen());
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
