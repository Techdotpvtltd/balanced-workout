// Project: 	   balanced_workout
// File:    	   custom_back_button
// Path:    	   lib/screens/components/custom_back_button.dart
// Author:       Ali Akbar
// Date:        04-05-24 13:32:34 -- Saturday
// Description:

import 'package:flutter/material.dart';

import '../../utils/extensions/navigation_service.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed, this.backgroundColor});
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed != null
          ? () => onPressed!
          : () {
              NavigationService.back();
            },
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
        backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? const Color(0xFF8B8B8B).withOpacity(0.2)),
        fixedSize: const WidgetStatePropertyAll(
          Size(54, 54),
        ),
      ),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }
}
