import 'dart:developer';

import 'package:balanced_workout/utils/extensions/string_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../app/app_manager.dart';
import '../exceptions/app_exceptions.dart';
import '../exceptions/auth_exceptions.dart';
import '../exceptions/data_exceptions.dart';
import '../exceptions/exception_parsing.dart';
import '../web_services/firebase_auth_serivces.dart';
import 'user_repo.dart';
import 'validations/check_validation.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

class AuthRepo {
  int userFetchFailureCount = 0;
  //  LoginUser ====================================
  Future<void> loginUser(
      {required String withEmail, required String withPassword}) async {
    try {
      // Make Validation
      await CheckVaidation.loginUser(email: withEmail, password: withPassword);
      final _ = await FirebaseAuthService()
          .login(withEmail: withEmail, withPassword: withPassword);
      await UserRepo().fetch();
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

  Future<void> sendEmailVerifcationLink() async {
    try {
      await FirebaseAuthService().sendEmailVerifcationLink();
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

//  RegisteredAUser ====================================
  Future<void> registeredUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      /// Make validation
      await CheckVaidation.onCreateUser(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      // Create user After validation
      final UserCredential userCredential = await FirebaseAuthService()
          .registerUser(email: email, password: password);
      await UserRepo().create(
        uid: userCredential.user?.uid ?? "",
        name: name,
        email: email,
      );
      if (kReleaseMode) {
        sendEmailVerifcationLink();
      }
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

  /// Return Login user object
  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  /// Perform Logout
  Future<void> performLogout() async {
    FirebaseAuthService().logoutUser();
  }

  /// Perform Logout
  Future<void> sendForgotPasswordEmail({required String atMail}) async {
    if (atMail == "") {
      throw AuthExceptionEmailRequired(errorCode: 01);
    }

    if (!atMail.isValidEmail()) {
      throw AuthExceptionInvalidEmail(errorCode: 01);
    }
    await FirebaseAuthService().resetPassword(email: atMail);
  }

  /// =========================== Social Auth Methods ================================
  //  Login With Apple ====================================
  Future<void> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      AuthCredential authCredential = OAuthProvider("apple.com").credential(
          accessToken: credential.authorizationCode,
          idToken: credential.identityToken);
      await FirebaseAuthService()
          .loginWithCredentials(credential: authCredential);
      await _fetchOrCreateUser();
    } catch (e) {
      throw throwAppException(e: e);
    }
  }

  /// Login With Fb
  Future<void> loginWithFB() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookAuthCred =
              FacebookAuthProvider.credential(result.accessToken!.tokenString);
          await FirebaseAuthService()
              .loginWithCredentials(credential: facebookAuthCred);
          await _fetchOrCreateUser();
          break;
        case LoginStatus.cancelled:
          throw DataExceptionCancelled();
        case LoginStatus.failed:
          log("[debug FacebookLogin] ${result.message}");
          throw throwAppException(e: result.message ?? "");
        default:
          log("[debug FacebookLogin] ${result.message}");
          throw throwAppException(e: result.message ?? "");
      }
    } catch (e) {
      log("[debug FacebookLogin] $e");
      throw throwAppException(e: e);
    }
  }

  // Mostly used for Social Account Authenticatopn
  Future<void> _fetchOrCreateUser() async {
    try {
      await UserRepo().fetch();
      userFetchFailureCount = 0;
    } on AppException catch (e) {
      if (e is AuthExceptionUserNotFound) {
        final User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          if (userFetchFailureCount <= 1) {
            await UserRepo().create(
              uid: user.uid,
              name: user.displayName ?? "",
              avatarUrl: user.photoURL,
              email: user.email ?? "",
            );
            AppManager().isNewUserWithCred = true;
            _fetchOrCreateUser();
          } else {
            throw throwAppException(e: e);
          }
          userFetchFailureCount += 1;
        }
        return;
      }
      throw throwAppException(e: e);
    }
  }

  //  Login With Google ====================================
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuthService().loginWithCredentials(credential: credential);
      await _fetchOrCreateUser();
    } catch (e) {
      throw throwAppException(e: e);
    }
  }
}
