import 'package:flutter/material.dart';
// Project: 	   balanced_workout
// File:    	   app
// Path:    	   lib/screens/app/app.dart
// Author:       Ali Akbar
// Date:        03-05-24 13:16:18 -- Saturday
// Description:
import '../onboarding/splash_screen.dart';

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
      theme: ThemeData(fontFamily: 'SfProDisplay'),
      home: const SplashScreen(),
    );
  }
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
