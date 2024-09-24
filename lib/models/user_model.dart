// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: dangling_library_doc_comments
/// Project: 	   playtogethher
/// File:    	   user_model
/// Path:    	   lib/model/user_model.dart
/// Author:       Ali Akbar
/// Date:        08-03-24 14:13:23 -- Friday
/// Description:

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final DateTime createdAt;
  final String? role;
  final bool? isActived;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? goal;
  final String? activityLevel;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    required this.createdAt,
    this.role,
    this.isActived,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? avatar,
    DateTime? createdAt,
    String? role,
    bool? isActived,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activityLevel,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
      isActived: isActived ?? this.isActived,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
      'createdAt': Timestamp.fromDate(createdAt),
      'role': role,
      'isActived': isActived,
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'goal': goal,
      'activityLevel': activityLevel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      role: map['role'] != null ? map['role'] as String : null,
      isActived: map['isActived'] != null ? map['isActived'] as bool : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      weight: map['weight'] != null ? map['weight'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      goal: map['goal'] != null ? map['goal'] as String : null,
      activityLevel:
          map['activityLevel'] != null ? map['activityLevel'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.empty() {
    return UserModel(
      uid: "",
      name: "",
      email: "",
      avatar: "",
      createdAt: DateTime.now(),
    );
  }
  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, avatar: $avatar, createdAt: $createdAt, role: $role, isActived: $isActived, gender: $gender, age: $age, weight: $weight, height: $height, goal: $goal, activityLevel: $activityLevel)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        other.role == role &&
        other.isActived == isActived &&
        other.gender == gender &&
        other.age == age &&
        other.weight == weight &&
        other.height == height &&
        other.goal == goal &&
        other.activityLevel == activityLevel;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        createdAt.hashCode ^
        role.hashCode ^
        isActived.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        goal.hashCode ^
        activityLevel.hashCode;
  }
}
