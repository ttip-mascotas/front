import "dart:math";

import "package:intl/intl.dart";

String formatDateToString(DateTime date) {
  return DateFormat("dd-MM-yy").format(date);
}

String formatDateToShortString(DateTime date) {
  return DateFormat("dd-MM").format(date);
}

String formatTimeToString(DateTime date) {
  return DateFormat("h:mm a").format(date);
}

DateTime parseUTCDateTimeISO8601StringToLocal(String date) {
  return DateTime.parse(date).toLocal();
}

String convertLocalDateTimeToIso8601UTCString(DateTime datetime) {
  return datetime.toUtc().toIso8601String();
}

DateTime parseDateStringAsDateTime(String date) {
  return DateFormat("dd-MM-yy").parse(date);
}

DateTime parseTimeStringAsDateTime(String timeOfDay) {
  final format = DateFormat("h:mm a");
  final selectedTime = format.parse(timeOfDay);
  final now = DateTime.now();
  final selectedDate = DateTime(
    now.year,
    now.month,
    now.day,
    selectedTime.hour,
    selectedTime.minute,
  );

  if (now.isBefore(selectedDate)) {
    return selectedDate;
  }

  return selectedDate.add(const Duration(days: 1));
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) {
    return "0 B";
  }
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return "${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}";
}

String convertAgeToString(int age) {
  if (age > 1) {
    return "${age.toString()} años";
  }
  return "${age.toString()} año";
}

String convertWeightToString(double weight) {
  return "${weight.ceil().toString()} Kg";
}
