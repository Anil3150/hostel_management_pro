import 'package:intl/intl.dart';

class CustomFormatDate {
   String formatChatTimestamp(String utcTimestamp) {
    try {
      if (utcTimestamp.isEmpty) return '';

      DateTime utcTime = DateTime.parse(utcTimestamp);
      DateTime istTime = utcTime.add(const Duration(hours: 5, minutes: 30));

      DateTime nowIst =
          DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));

      if (istTime.year == nowIst.year &&
          istTime.month == nowIst.month &&
          istTime.day == nowIst.day) {
        return DateFormat.jm().format(istTime);
      }

      DateTime yesterday = nowIst.subtract(const Duration(days: 1));
      if (istTime.year == yesterday.year &&
          istTime.month == yesterday.month &&
          istTime.day == yesterday.day) {
        return 'Yesterday';
      }

      int difference = nowIst.difference(istTime).inDays;
      if (difference < 7) {
        return DateFormat.E().format(istTime);
      }

      return DateFormat('dd/MM/yyyy').format(istTime);
    } catch (e) {
      print('Invalid timestamp: $utcTimestamp — Error: $e');
      return 'Invalid date';
    }
  }

  String formatTransTimestamp(String utcTimestamp) {
  try {
    if (utcTimestamp.isEmpty) return '';

    DateTime utcTime = DateTime.parse(utcTimestamp);
    DateTime istTime = utcTime.add(const Duration(hours: 5, minutes: 30));

    DateTime nowIst =
        DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));

    final timeFormat = DateFormat.jm(); // 02:30 PM
    final dateFormat = DateFormat('dd MMM yyyy'); // 02 Sep 2025

    // Today
    if (istTime.year == nowIst.year &&
        istTime.month == nowIst.month &&
        istTime.day == nowIst.day) {
      return "${timeFormat.format(istTime)}, Today";
    }

    // Yesterday
    DateTime yesterday = nowIst.subtract(const Duration(days: 1));
    if (istTime.year == yesterday.year &&
        istTime.month == yesterday.month &&
        istTime.day == yesterday.day) {
      return "${timeFormat.format(istTime)}, Yesterday";
    }

    // Older → show time + date
    return "${timeFormat.format(istTime)}, ${dateFormat.format(istTime)}";
  } catch (e) {
    print('Invalid timestamp: $utcTimestamp — Error: $e');
    return 'Invalid date';
  }
}


}