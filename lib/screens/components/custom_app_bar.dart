import 'package:flutter/material.dart';

import 'custom_back_button.dart';
// Project: 	   balanced_workout
// File:    	   custom_app_bar
// Path:    	   lib/screens/components/custom_app_bar.dart
// Author:       Ali Akbar
// Date:        04-05-24 13:32:15 -- Saturday
// Description:

PreferredSizeWidget customAppBar({
  Color? background,
  String? title,
  bool showBack = true,
  double topPadding = 1,
  double rightPadding = 1,
  double leftPadding = 1,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(topPadding + 60),
    child: Padding(
      padding: EdgeInsets.only(
          top: topPadding, right: rightPadding, left: leftPadding),
      child: AppBar(
        backgroundColor: background ?? Colors.transparent,
        leadingWidth: showBack ? 90 : 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: showBack ? const Center(child: CustomBackButton()) : null,
        centerTitle: false,
        title: Text(
          title ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
