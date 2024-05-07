import 'package:flutter/material.dart';

import 'screens/onboarding/splash_screen.dart';
// Project: 	   balanced_workout
// File:    	   app
// Path:    	   lib/screens/app/app.dart
// Author:       Ali Akbar
// Date:        03-05-24 13:16:18 -- Saturday
// Description:

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SfProDisplay',
        scaffoldBackgroundColor: const Color(0xFF161616),
      ),
      home: const SplashScreen(),
    );
  }
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
