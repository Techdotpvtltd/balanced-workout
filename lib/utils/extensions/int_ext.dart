// Project: 	   balanced_workout
// File:    	   int_ext
// Path:    	   lib/utils/extensions/int_ext.dart
// Author:       Ali Akbar
// Date:        09-07-24 17:07:17 -- Tuesday
// Description:

extension CustomInt on int {
  String formatTime() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final secs = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
