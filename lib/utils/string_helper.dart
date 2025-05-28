import 'package:intl/intl.dart';

class StringHelper {
  static String formatDateTime({required DateTime dateTime, bool onlyHours = false}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if(onlyHours) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      if (date == today) {
        return "Today at ${DateFormat('HH:mm').format(dateTime)}";
      } else if (date == yesterday) {
        return "Yesterday at ${DateFormat('HH:mm').format(dateTime)}";
      } else {
        return "${DateFormat('d MMMM').format(dateTime)} ${DateFormat('HH:mm').format(dateTime)}";
      }
    }
  }
}
