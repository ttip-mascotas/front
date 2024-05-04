import 'dart:math';

import 'package:intl/intl.dart';

String formatDateToString(DateTime date) {
  return DateFormat("dd-MM-yy").format(date);
}

DateTime formatStringToDateTimeFromBack(String date) {
  return DateTime.parse(date);
}

DateTime formatStringToDateTime(String date) {
  return DateFormat("dd-MM-yy").parse(date);
}

DateTime formatTimeOfDayToDateTime(String timeOfDay) {
  final format = DateFormat("h:mm a");
  final selectedDate = format.parse(timeOfDay);
  final now = DateTime.now();

  return DateTime(
    now.year,
    now.month,
    now.day + 1,
    selectedDate.hour,
    selectedDate.minute,
  );
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) {
    return "0 B";
  }
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return "${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}";
}
