import 'package:balanced_workout/utils/extensions/string_extension.dart';

import '../../exceptions/auth_exceptions.dart';
import '../../exceptions/data_exceptions.dart';

class CheckVaidation {
  static Future<void> loginUser({String? email, String? password}) async {
    if (email == null || email == "") {
      throw AuthExceptionEmailRequired(errorCode: 01);
    }

    if (!email.isValidEmail()) {
      throw AuthExceptionInvalidEmail(errorCode: 01);
    }

    if (password == null || password == "") {
      throw AuthExceptionPasswordRequired(errorCode: 02);
    }
  }

  static Future<void> onCreateEvent({
    required String title,
    required List<String> images,
    DateTime? dateTime,
    String? maxPersons,
  }) async {
    if (title == "") {
      throw DataExceptionRequiredField(
          message: "Please Enter Event name.", errorCode: 1);
    }

    if (maxPersons == "" || maxPersons == null) {
      throw DataExceptionRequiredField(
          message:
              "Please add the value of maximum persons can join the event.");
    }

    if (dateTime == null) {
      throw DataExceptionRequiredField(message: "Please select date and time.");
    }

    if (images.isEmpty) {
      throw DataExceptionRequiredField(
          message: "Please upload at least 1 image");
    }
  }

  static Future<void> addItem(
      {required String title, required String category}) async {
    if (title == "") {
      throw AuthExceptionRequiredField(
          message: "Please Enter item name.", errorCode: 1);
    }

    if (category == "") {
      throw AuthExceptionRequiredField(message: "Please select a category");
    }
  }

  static Future<void> onCreateUser({
    String? name,
    String? password,
    String? confirmPassword,
    String? email,
    // String? phone,
  }) async {
    if (name == null || name == "") {
      throw AuthExceptionFullNameRequired(errorCode: 01);
    }

    if (email == null || email == "") {
      throw AuthExceptionEmailRequired(errorCode: 02);
    }

    if (!email.isValidEmail()) {
      throw AuthExceptionInvalidEmail(errorCode: 02);
    }

    // if (phone == null || phone == "") {
    //   throw AuthExceptionRequiredPhone();
    // }

    if (password == null || password == "") {
      throw AuthExceptionPasswordRequired(errorCode: 03);
    }

    if (password.length < 6) {
      throw AuthExceptionWeekPassword(errorCode: 03);
    }

    if (confirmPassword == null || confirmPassword == "") {
      throw AuthExceptionConfirmPasswordRequired(errorCode: 04);
    }

    if (confirmPassword != password) {
      throw AuthExceptionConfirmPasswordDoesntMatching(errorCode: 04);
    }
  }

  static Future<void> updateUser({
    String? name,
    String? email,
    String? phone,
  }) async {
    if (name == null || name == "") {
      throw AuthExceptionFullNameRequired();
    }

    if (email == null) {
      throw AuthExceptionEmailRequired();
    }

    if (!email.isValidEmail()) {
      throw AuthExceptionInvalidEmail();
    }

    if (phone == null || phone == "") {
      throw AuthExceptionRequiredPhone();
    }
  }

  static Future<void> chat({String? name, required int max}) async {
    if (name == null || name == "") {
      throw DataExceptionRequiredField(message: "Community name required");
    }

    if (max < 0 || max > 250) {
      throw DataExceptionRequiredField(
          message: "Maximum Limit of community is 1 to 250");
    }
  }
}
