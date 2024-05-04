// Project: 	   balanced_workout
// File:    	   profile_picker_screen
// Path:    	   lib/screens/onboarding/profile_picker_screen.dart
// Author:       Ali Akbar
// Date:        04-05-24 18:05:31 -- Saturday
// Description:

import 'package:dotted_box/dotted_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_theme.dart';
import 'components/information_widget.dart';

class ProfilePickerScreen extends StatelessWidget {
  const ProfilePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InformationWidget(
      title: "Profile Picture",
      subTitle: "Please add your profile picture",
      middleWidget: DottedBox(
        width: 145,
        height: 145,
        borderColor: AppTheme.primaryColor1,
        borderThickness: 2,
        dashCounts: 30,
        borderShape: Shape.circle,
        child: SvgPicture.asset(AppAssets.uploadIcon),
      ),
      onPressedNext: () {},
      rightButtonTitle: "Start",
    );
  }
}
