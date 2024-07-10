import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app_manager.dart';
import '../../exceptions/app_exceptions.dart';
import '../../models/user_model.dart';
import '../../repos/user_repo.dart';
import 'user_event.dart';
import 'user_state.dart';

/// Project: 	   playtogethher
/// File:    	   user_bloc
/// Path:    	   lib/blocs/user/user_bloc.dart
/// Author:       Ali Akbar
/// Date:        13-03-24 15:43:26 -- Wednesday
/// Description:

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateInitial()) {
    /// OnUpdateProfile Event
    on<UserEventUpdateProfile>(
      (event, emit) async {
        try {
          UserModel user = AppManager().user;
          String avatarUrl = user.avatar;
          final isEmptyHost = Uri.parse(event.avatar ?? "").host.isEmpty;
          if ((event.avatar != "" && event.avatar != null) && isEmptyHost) {
            emit(UserStateAvatarUploading());
            avatarUrl =
                await UserRepo().uploadProfile(path: event.avatar ?? "");
            emit(UserStateAvatarUploaded());
            user = user.copyWith(avatar: avatarUrl);
          }

          if (event.activityLevel != null) {
            user = user.copyWith(activityLevel: event.activityLevel);
          }

          if (event.age != null) {
            user = user.copyWith(age: event.age);
          }

          if (event.name != null) {
            user = user.copyWith(name: event.name);
          }

          if (event.email != null) {
            user = user.copyWith(email: event.email);
          }

          if (event.gender != null) {
            user = user.copyWith(gender: event.gender);
          }

          if (event.goal != null) {
            user = user.copyWith(goal: event.goal);
          }
          if (event.height != null) {
            user = user.copyWith(height: event.height);
          }
          if (event.weight != null) {
            user = user.copyWith(weight: event.weight);
          }

          if (event.role != null) {
            user = user.copyWith(role: event.role);
          }
          emit(UserStateProfileUpdating());
          final UserModel updatedModel = await UserRepo().update(user: user);
          emit(UserStateProfileUpdated(user: updatedModel));
        } on AppException catch (e) {
          emit(UserStateProfileUpdatingFailure(exception: e));
        }
      },
    );

    // OnFindUser
    on<UserEventSearchUsers>(
      (event, emit) async {
        try {
          emit(UserStateSearchFetching());
          final List<UserModel> users = await UserRepo().fetchUsersWith(
              searchName: event.search, ignoreIds: event.ignoreIds);
          emit(UserStateSearchFetched(users: users));
        } on AppException catch (e) {
          emit(UserStateSearchFetchFailure(exception: e));
        }
      },
    );
  }
}
