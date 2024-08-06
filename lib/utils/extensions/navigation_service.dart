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
}
