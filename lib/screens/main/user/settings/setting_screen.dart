// Project: 	   balanced_workout
// File:    	   setting_screen
// Path:    	   lib/screens/main/user/setting_screen.dart
// Author:       Ali Akbar
// Date:        09-05-24 11:04:48 -- Thursday
// Description:

import 'dart:io' show Platform;

import 'package:balanced_workout/blocs/subscription/subscription_state.dart';
import 'package:balanced_workout/blocs/subscription/subsription_bloc.dart';
import 'package:balanced_workout/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app_manager.dart';
import '../../../../blocs/auth/auth_bloc.dart';
import '../../../../blocs/auth/auth_event.dart';
import '../../../../blocs/auth/auth_state.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/dialogs/dialogs.dart';
import '../../../../utils/extensions/navigation_service.dart';
import '../../../components/avatar_widget.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_child_button.dart';
import '../../../components/custom_container.dart';
import '../../../components/custom_paddings.dart';
import '../../../components/custom_scaffold.dart';
import '../../../onboarding/forgot_screen.dart';
import '../../../onboarding/splash_screen.dart';
import 'edit_profile_screen.dart';
import 'subscription_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final SubscriptionBloc subscriptionBloc;
  late SubscriptionModel activeSub = subscriptionBloc.getActiveSubscription();

  @override
  void initState() {
    subscriptionBloc = context.read<SubscriptionBloc>();
    super.initState();
  }

  void trigegrLogoutEvent(AuthBloc bloc) {
    CustomDialogs().alertBox(
      title: "Logout Action",
      message: "Are you sure to logout this account?",
      negativeTitle: "No",
      positiveTitle: "Yes",
      onPositivePressed: () {
        bloc.add(AuthEventPerformLogout());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (_, state) {
            if (state is SubscriptionStateUpdated) {
              setState(() {
                activeSub = subscriptionBloc.getActiveSubscription();
              });
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLogout) {
              NavigationService.offAll(const SplashScreen());
            }
          },
        ),
      ],
      child: CustomScaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomPadding(
          bottom: 80,
          child: CustomButton(
            onPressed: () {
              trigegrLogoutEvent(context.read<AuthBloc>());
            },
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
                  Expanded(
                    child: Row(
                      children: [
                        AvatarWidget(
                          avatarUrl: AppManager().user.avatar,
                          placeholderChar:
                              AppManager().user.name.characters.firstOrNull,
                          backgroundColor: Colors.black,
                          width: 79,
                          height: 79,
                        ),
                        gapW12,

                        /// Text Widgets
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppManager().user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppTheme.titleDarkColor1,
                                ),
                              ),
                              Text(
                                AppManager().user.email,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppTheme.titleDarkColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Edit Button
                  CircleButton(
                    onPressed: () {
                      NavigationService.go(const EditProfileScreen());
                    },
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
            // gapH10,
            // CustomChildButton(
            //   onPressed: () {
            //     NavigationService.go(const ContactUsScreen());
            //   },
            //   child: Row(
            //     children: [
            //       SvgPicture.asset(
            //         AppAssets.infoIcon,
            //         height: 24,
            //         colorFilter:
            //             const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            //       ),
            //       gapW30,
            //       Text(
            //         "Contact Us",
            //         style: GoogleFonts.poppins(
            //           color: Colors.white,
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            /// Subscription Button
            gapH10,

            //TODO: Remove this condition when app is shifted to client account
            if (Platform.isIOS)
              CustomChildButton(
                onPressed: () {
                  NavigationService.go(const SubscriptionScreen());
                },
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
            gapH10,
            CustomChildButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    "https://www.freeprivacypolicy.com/live/9d9f6c3b-0ebc-408c-92da-dbfe3c94058b"));
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.privacy_tip_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  gapW30,
                  Text(
                    "Privacy Policy",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            gapH10,
            CustomChildButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    "https://pro-akbar.github.io/balance-workout-terms/"));
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.edit_document,
                    size: 24,
                    color: Colors.white,
                  ),
                  gapW30,
                  Text(
                    "Terms and Conditions",
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
              onPressed: () {
                CustomDialogs().deleteBox(
                  title: "Confirm Account Deletion",
                  message:
                      "Are you sure you want to delete your account? This action cannot be undone.\n\nDon't forget to cancel any active subscriptions before deleting your account.",
                  onPositivePressed: () {
                    CustomDialogs().alertBox(
                      title: "Confirm Again",
                      message: "Are you sure you want to delete your account?",
                      onPositivePressed: () {
                        context
                            .read<AuthBloc>()
                            .add(AuthEventPerformDeletion());
                      },
                      positiveTitle: "Yes, Delete it",
                    );
                  },
                );
              },
              child: Text(
                "Delete Account",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            /// Subscription Widget
            gapH32,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 38),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: AppTheme.primaryColor1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Title Row
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activeSub.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (activeSub.latestPurchaseDate != "") gapH4,
                      if (activeSub.latestPurchaseDate != "")
                        Text(
                          activeSub.latestPurchaseDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.27,
                          ),
                        ),
                    ],
                  ),

                  /// Price Widget
                  Text.rich(
                    TextSpan(
                      text: activeSub.storeProduct?.priceString ?? "0",
                      children: [
                        if (activeSub.storeProduct != null)
                          TextSpan(
                            text: "/${activeSub.period}",
                            style: const TextStyle(
                              fontSize: 14.27,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
