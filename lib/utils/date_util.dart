import 'package:flutter/material.dart';

class DateUtil {
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getMessageTime(
      {required BuildContext context, required String time}) {
    final sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final now = DateTime.now();

    if (sent.year == now.year &&
        sent.month == now.month &&
        sent.day == now.day) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return '${sent.day} ${_getMonth(sent.month)}';
  }

  static String getDateMessage(
      {required BuildContext context, required String time}) {
    final sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final now = DateTime.now();

    if (sent.year == now.year &&
        sent.month == now.month &&
        sent.day == now.day) {
      return '';
    }
    return '${sent.day} ${_getMonth(sent.month)}';
  }

  static String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }
}
