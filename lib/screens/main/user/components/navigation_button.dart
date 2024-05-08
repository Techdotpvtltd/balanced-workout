// Project: 	   balanced_workout
// File:    	   navigation_button
// Path:    	   lib/screens/main/user/components/navigation_button.dart
// Author:       Ali Akbar
// Date:        06-05-24 14:28:36 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../../components/circle_button.dart';
import '../../../components/custom_ink_well.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});
  final String icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: AppTheme.darkWidgetColor,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Top Arrow
            Align(
              alignment: Alignment.topRight,
              child: CircleButton(
                onPressed: () {},
                icon: AppAssets.upwardIcon,
              ),
            ),

            /// Center Text and Icon
            Center(
              child: Column(
                children: [
                  // Icon
                  Image.asset(
                    icon,
                    height: 63,
                  ),
                  gapH10,
                  Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFD4D4D4),
                      fontSize: 14,
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
