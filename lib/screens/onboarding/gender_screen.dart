// Project: 	   balanced_workout
// File:    	   gender_screen
// Path:    	   lib/screens/onboarding/gender_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 15:11:40 -- Saturday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_manager.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/constants/constants.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_ink_well.dart';
import 'age_screen.dart';
import 'components/information_widget.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen>
    with WidgetsBindingObserver {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "Tell us about yourself! ",
      subTitle: "To give you a better experience we nee\nto know your gender ",
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
                      i == 0
                          ? AppAssets.menGenderIcon
                          : AppAssets.femaleGenderIcon,
                      colorFilter: ColorFilter.mode(
                        selectedIndex == i
                            ? Colors.black
                            : const Color(0xFFB6B6B6),
                        BlendMode.srcIn,
                      ),
                    ),
                    gapH14,
                    Text(
                      i == 0 ? "Male" : "Female",
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
        AppManager().user = AppManager()
            .user
            .copyWith(gender: selectedIndex == 0 ? "male" : "female");
        NavigationService.go(const AgeScreen());
      },
    );
  }
}
