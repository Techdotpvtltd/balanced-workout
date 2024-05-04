import 'package:flutter/material.dart';

import 'custom_back_button.dart';
// Project: 	   balanced_workout
// File:    	   custom_app_bar
// Path:    	   lib/screens/components/custom_app_bar.dart
// Author:       Ali Akbar
// Date:        04-05-24 13:32:15 -- Saturday
// Description:

PreferredSizeWidget customAppBar({Color? background, String? title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      backgroundColor: background ?? Colors.transparent,
      automaticallyImplyLeading: false,
      leadingWidth: 120,
      leading: const Center(child: CustomBackButton()),
      centerTitle: false,
      title: Text(
        title ?? "",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
