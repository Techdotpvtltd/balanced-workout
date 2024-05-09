// Project: 	   balanced_workout
// File:    	   custom_child_button
// Path:    	   lib/screens/components/custom_child_button.dart
// Author:       Ali Akbar
// Date:        09-05-24 11:46:04 -- Thursday
// Description:

import 'package:flutter/material.dart';

class CustomChildButton extends StatelessWidget {
  const CustomChildButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.backgroundColor});
  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 22,
        )),
        backgroundColor: MaterialStatePropertyAll(
            backgroundColor ?? const Color(0xFF303030)),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      child: child,
    );
  }
}
