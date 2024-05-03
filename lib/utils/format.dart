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
