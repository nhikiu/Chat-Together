import 'package:flutter/material.dart';

class DateUtil {
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getLastMessageTime(
      {required BuildContext context, required String time}) {
    final sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final now = DateTime.now();

    if (sent.year == now.year &&
        sent.month == now.month &&
        sent.day == now.day) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return '${sent.day} ${sent.month}';
  }
}
