// Project: 	   balanced_workout
// File:    	   user_type_screen
// Path:    	   lib/screens/onboarding/user_type_screen.dart
// Author:       Ali Akbar
// Date:        10-05-24 12:23:57 -- Friday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_manager.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_ink_well.dart';
import '../main/coach/coach_home_screen.dart';
import '../main/user/main_user_screen.dart';
import 'components/information_widget.dart';
import 'gender_screen.dart';
import 'profile_picker_screen.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key, this.isComingFromSignup = false});
  final bool isComingFromSignup;

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "Who are you? ",
      subTitle: "To give you a better experience we need\nto know you.",
      showBackButton: false,
      middleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 2; i++)
            CustomInkWell(
              onTap: () {
                setState(() {
                  selectedIndex = i;
                });
                AppManager().isUserLogin = selectedIndex == 0;
              },
              child: Container(
                width: 140,
                height: 140,
                margin: EdgeInsets.only(
                  bottom: i == 0 ? 47 : 0,
                ),
                decoration: BoxDecoration(
                  color: selectedIndex == i
                      ? AppTheme.primaryColor1
                      : const Color(0xFF2C2C2E),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      i == 0 ? AppAssets.traineeIcon : AppAssets.trainerIcon,
                      height: 40,
                      colorFilter: ColorFilter.mode(
                        selectedIndex == i
                            ? Colors.black
                            : const Color(0xFFB6B6B6),
                        BlendMode.srcIn,
                      ),
                    ),
                    gapH14,
                    Text(
                      i == 0 ? "Trainee" : "Trainer",
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == i
                            ? Colors.black
                            : const Color(0xFFB6B6B6),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
      onPressedNext: () {
        NavigationService.go(
          widget.isComingFromSignup
              ? selectedIndex == 0
                  ? const GenderScreen()
                  : const ProfilePickerScreen()
              : selectedIndex == 0
                  ? const MainUserScreen()
                  : const CoachHomeScreen(),
        );
      },
    );
  }
}
