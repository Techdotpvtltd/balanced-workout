import 'dart:developer';

import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime onlyDate() {
    return DateTime(year, month, day);
  }

  String dateToString(String pattern) {
    return DateFormat(pattern).format(this);
  }

  String formatChatDateToString() {
    final days = DateTime.now().difference(this).inDays;
    if (days == 0) {
      return "Today";
    }
    if (days == 1) {
      return "Yesterday";
    }

    if (days > 1 && days < 7) {
      return dateToString("EEEE");
    }
    return dateToString("dd-MMM-yyyy");
  }
}

DateTime startOfMonthDate() {
  final now = DateTime.now();
  log(DateTime(now.year, now.month, 1).toString());
  return DateTime(now.year, now.month, 1);
}

double monthDayPercentage() {
  final now = DateTime.now();
  final totalCurrentMonthDays = DateTime(now.year, now.month, 0).day;
  return (now.day / totalCurrentMonthDays) * 100;
}

extension STR on String {
  String formatDate(String from, String to) {
    final date = DateFormat(from).parse(this);
    return date.dateToString(to);
  }

  DateTime toDate(String pattern) {
    return DateFormat(pattern).parse(this);
  }
}
