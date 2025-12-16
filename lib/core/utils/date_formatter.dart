import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String format(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat('MM-dd-yyyy HH:mm').format(date);
  }
}
