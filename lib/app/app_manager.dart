// Project: 	   balanced_workout
// File:    	   app_manager
// Path:    	   lib/app/app_manager.dart
// Author:       Ali Akbar
// Date:        10-05-24 12:21:41 -- Friday
// Description:

class AppManager {
  static final AppManager _instance = AppManager._internal();
  AppManager._internal();
  factory AppManager() => _instance;

  bool isUserLogin = true;
}
