// Project: 	   balanced_workout
// File:    	   circle_button
// Path:    	   lib/screens/components/circle_button.dart
// Author:       Ali Akbar
// Date:        06-05-24 13:47:28 -- Monday
// Description:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/app_theme.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.onPressed, required this.icon});
  final VoidCallback onPressed;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(icon),
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppTheme.darkButtonColor),
        padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
      ),
    );
  }
}
