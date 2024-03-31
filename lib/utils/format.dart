import 'package:intl/intl.dart';

String formatDateToString(DateTime date) {
  return DateFormat("dd-MM-yy").format(date);
}