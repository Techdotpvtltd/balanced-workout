import 'dart:developer';

import 'package:flutter/material.dart';

import '../../main.dart';

// Project: 	   listi_shop
// File:    	   navigation_service
// Path:    	   lib/utils/extensions/navigation_service.dart
// Author:       Ali Akbar
// Date:        03-05-24 13:52:08 -- Friday
// Description:

class NavigationService {
  static Future<dynamic> go(Widget child) async {
    log("${child.runtimeType}", name: "Navigate To", time: DateTime.now());
    return await Navigator.push(
        navKey.currentContext!, MaterialPageRoute(builder: (context) => child));
  }

  static void off(Widget child) {
    log("${child.runtimeType}",
        name: "Pop and Navigate To", time: DateTime.now());
    Navigator.pushReplacement(
        navKey.currentContext!, MaterialPageRoute(builder: (context) => child));
  }

  static void offAll(Widget child) {
    log("${child.runtimeType}", name: "Pop", time: DateTime.now());
    Navigator.pushAndRemoveUntil(navKey.currentContext!,
        MaterialPageRoute(builder: (context) => child), (route) => false);
  }

  static void back() {
    log("", name: "Back", time: DateTime.now());
    Navigator.pop(navKey.currentContext!);
  }

  static Future<dynamic> present(Widget child) async {
    log("${child.runtimeType}", name: "Navigate To", time: DateTime.now());

    return await Navigator.push(
      navKey.currentContext!,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Scale and Fade transition combined
          var scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut));
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeIn));

          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          );
        },
        transitionDuration:
            const Duration(milliseconds: 300), // Adjust as needed
        reverseTransitionDuration:
            const Duration(milliseconds: 300), // For closing transition
        barrierDismissible: true, // Allows dismissal by tapping outside
        opaque: false, // Makes the background transparent
      ),
    );
  }
}
