// Project: 	   balanced_workout
// File:    	   methods
// Path:    	   lib/utils/extensions/methods.dart
// Author:       Ali Akbar
// Date:        08-05-24 13:40:22 -- Wednesday
// Description:

List<DateTime> getDates({int? ofYear, required int ofMonth}) {
  final DateTime now = DateTime.now().toUtc();
  int year = ofYear ?? now.year;
  return List.generate(
    DateTime(year, ofMonth + 1, 0).day,
    (index) => DateTime(year, ofMonth, index + 1),
  );
}
