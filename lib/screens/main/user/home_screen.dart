// Project: 	   balanced_workout
// File:    	   home_screen
// Path:    	   lib/screens/main/user/home_screen.dart
// Author:       Ali Akbar
// Date:        06-05-24 13:09:09 -- Monday
// Description:

import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/constants/constants.dart';
import '../../components/avatar_widget.dart';
import '../../components/circle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: SCREEN_WIDTH * 0.28,
            toolbarHeight: SCREEN_HEIGHT,
            leading: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppTheme.darkButtonColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(167),
                    bottomRight: Radius.circular(167)),
              ),

              /// Avatar Widget
              child: const Align(
                alignment: Alignment.centerRight,
                child: AvatarWidget(
                  avatarUrl: "",
                  width: 52,
                  height: 52,
                  backgroundColor: Colors.black,
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
                    text: "Akbar",
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
              CircleButton(
                icon: AppAssets.magnifierIcon,
                onPressed: () {},
              ),
              gapW10,
              CircleButton(
                icon: AppAssets.bellIcon,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: Placeholder(),
      ),
    );
  }
}
