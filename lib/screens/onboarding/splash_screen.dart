// Project: 	   balanced_workout
// File:    	   splash_screen
// Path:    	   lib/screens/onboarding/splash_screen.dart
// Author:       Ali Akbar
// Date:        03-05-24 13:57:39 -- Friday
// Description:

import 'package:flutter/material.dart';

import '../../utils/constants/app_assets.dart';
import '../../utils/extensions/navigation_service.dart';
import '../components/custom_scaffold.dart';
import 'walkthrough_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void triggerSplashEvent() async {
    await Future.delayed(const Duration(seconds: 2));
    NavigationService.offAll(const WalkthroughScreen());
  }

  @override
  void initState() {
    triggerSplashEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImagePath: AppAssets.splashBackground,
      body: Center(
        child: Image.asset(AppAssets.logo),
      ),
    );
  }
}
