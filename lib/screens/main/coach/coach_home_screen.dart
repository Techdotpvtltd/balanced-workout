// Project: 	   balanced_workout
// File:    	   coach_home_screen
// Path:    	   lib/screens/main/coach/coach_home_screen.dart
// Author:       Ali Akbar
// Date:        10-05-24 13:31:42 -- Friday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/dialogs/dialogs.dart';
import '../../../utils/extensions/navigation_service.dart';
import '../../components/avatar_widget.dart';
import '../../components/circle_button.dart';
import '../../components/custom_ink_well.dart';
import '../../components/custom_paddings.dart';
import '../../components/custom_title_textfiled.dart';
import '../user/notification_screen.dart';
import '../user/settings/edit_profile_screen.dart';

class CoachHomeScreen extends StatefulWidget {
  const CoachHomeScreen({super.key});

  @override
  State<CoachHomeScreen> createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen> {
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leadingWidth: SCREEN_WIDTH * 0.28,
          leading: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: const BoxDecoration(
              color: AppTheme.darkButtonColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(167),
                  bottomRight: Radius.circular(167)),
            ),

            /// Avatar Widget
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomInkWell(
                onTap: () {
                  NavigationService.go(const EditProfileScreen());
                },
                child: const AvatarWidget(
                  avatarUrl: "",
                  width: 52,
                  height: 52,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
          titleSpacing: 8,

          /// Tite Widget
          title: const Text.rich(
            TextSpan(
              text: "Hi, ",
              children: [
                TextSpan(
                  text: "Tylor",
                  style: TextStyle(
                    color: AppTheme.primaryColor1,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: false,

          /// Action Widget
          actions: [
            gapW10,
            CircleButton(
              icon: AppAssets.bellIcon,
              onPressed: () {
                NavigationService.go(const NotificationScreen());
              },
            ),
            gapW10,
            CircleButton(
              icon: AppAssets.logoutIcon,
              iconSize: const Size(18, 18),
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
              onPressed: () {
                trigegrLogoutEvent(context.read<AuthBloc>());
              },
            ),
            gapW30,
          ],
        ),
      ),

      /// Content
      body: const CustomPadding(
        top: 48,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search TF
            CustomTextField(
              hintText: "Search Communities",
            ),
            gapH20,
            Text(
              'Community',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.only(top: 20),
            //     itemCount: 13,
            //     itemBuilder: (context, index) {
            //       return const Padding(
            //         padding: EdgeInsets.symmetric(vertical: 9),
            //         child: ChatWidget(),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
