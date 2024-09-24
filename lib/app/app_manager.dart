// Project: 	   balanced_workout
// File:    	   app_manager
// Path:    	   lib/app/app_manager.dart
// Author:       Ali Akbar
// Date:        10-05-24 12:21:41 -- Friday
// Description:

import '../models/user_model.dart';

class AppManager {
  static final AppManager _instance = AppManager._internal();
  AppManager._internal();
  factory AppManager() => _instance;

  bool isUserLogin = true;

  String screenTitle = "";
  UserModel user = UserModel.empty();
  bool isNewUserWithCred = false;

  void clearAll() {
    user = UserModel.empty();
    isNewUserWithCred = false;
  }

  List<Map<String, List<String>>> records = [
    {
      "Strength Training": [
        "Weights",
        "Resistance Bands",
        "Bodyweight Exercises"
      ]
    },
    {
      "Cardio Workout": ["Running", "Cycling", "Jump Rope"]
    },
    {
      "Yoga Classes": ["Hatha Yoga", "Vinyasa Yoga", "Power Yoga"]
    }
  ];
}
