// ignore_for_file: public_member_api_docs, sort_constructors_first
// Project: 	   balanced_workout_panel
// File:    	   set_model
// Path:    	   lib/models/set_model.dart
// Author:       Ali Akbar
// Date:        14-06-24 16:32:15 -- Friday
// Description:

class SetModel {
  final int position;
  final String name;
  final String? value;
  SetModel({
    required this.position,
    required this.name,
    this.value,
  });

  factory SetModel.fromMap(Map<String, dynamic> map) {
    return SetModel(
      position: map['position'] as int,
      name: map['name'] as String,
      value: map['value'] as String? ?? "",
    );
  }
}
