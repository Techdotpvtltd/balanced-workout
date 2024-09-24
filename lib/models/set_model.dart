// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Project: 	   balanced_workout_panel
// File:    	   set_model
// Path:    	   lib/models/set_model.dart
// Author:       Ali Akbar
// Date:        14-06-24 16:32:15 -- Friday
// Description:

class SetNameModel {
  final String name;
  SetNameModel({required this.name});

  SetNameModel copyWith({String? name}) {
    return SetNameModel(name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name};
  }

  factory SetNameModel.fromMap(Map<String, dynamic> map) {
    return SetNameModel(name: map['name'] as String);
  }

  String toJson() => json.encode(toMap());

  factory SetNameModel.fromJson(String source) =>
      SetNameModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SetNameModel(name: $name)';

  @override
  bool operator ==(covariant SetNameModel other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class SetValueModel {
  final int row;
  final int col;
  final String? value;
  SetValueModel({
    required this.row,
    required this.col,
    this.value,
  });

  SetValueModel copyWith({
    int? row,
    int? col,
    String? value,
  }) {
    return SetValueModel(
      row: row ?? this.row,
      col: col ?? this.col,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'row': row,
      'col': col,
      'value': value,
    };
  }

  factory SetValueModel.fromMap(Map<String, dynamic> map) {
    return SetValueModel(
      row: map['row'] as int,
      col: map['col'] as int,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetValueModel.fromJson(String source) =>
      SetValueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SetValueModel(row: $row, col: $col, value: $value)';

  @override
  bool operator ==(covariant SetValueModel other) {
    if (identical(this, other)) return true;

    return other.row == row && other.col == col && other.value == value;
  }

  @override
  int get hashCode => row.hashCode ^ col.hashCode ^ value.hashCode;
}
