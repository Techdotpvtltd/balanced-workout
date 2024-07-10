// ignore: dangling_library_doc_comments
/// Project: 	   playtogethher
/// File:    	   user_event
/// Path:    	   lib/blocs/user/user_event.dart
/// Author:       Ali Akbar
/// Date:        13-03-24 15:41:39 -- Wednesday
/// Description:
///

abstract class UserEvent {}

/// Update Profile Event
class UserEventUpdateProfile extends UserEvent {
  final String? avatar;
  final String? gender;
  final String? name;
  final String? email;
  final int? age;
  final int? weight;
  final int? height;
  final String? goal;
  final String? activityLevel;
  final String? role;

  UserEventUpdateProfile(
      {this.avatar,
      this.gender,
      this.name,
      this.email,
      this.age,
      this.weight,
      this.height,
      this.goal,
      this.role,
      this.activityLevel});
}

class UserEventSearchUsers extends UserEvent {
  final String search;
  final List<String> ignoreIds;

  UserEventSearchUsers({required this.search, required this.ignoreIds});
}
