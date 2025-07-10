import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'hh:mm a';
  static const String displayDateTimeFormat = 'MMM dd, yyyy hh:mm a';

  /// Combine date and time into a single DateTime
  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  /// Format DateTime to display date
  static String formatDate(DateTime dateTime) {
    return DateFormat(displayDateFormat).format(dateTime);
  }

  /// Format DateTime to display time
  static String formatTime(DateTime dateTime) {
    return DateFormat(displayTimeFormat).format(dateTime);
  }

  /// Format DateTime to display date and time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(displayDateTimeFormat).format(dateTime);
  }

  /// Format DateTime for API calls
  static String formatApiDateTime(DateTime dateTime) {
    return DateFormat(dateTimeFormat).format(dateTime);
  }

  /// Parse API date string to DateTime
  static DateTime parseApiDateTime(String dateString) {
    return DateFormat(dateTimeFormat).parse(dateString);
  }

  /// Get time difference in human readable format
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  /// Get time until appointment
  static String getTimeUntil(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays > 0) {
      return 'In ${difference.inDays} day${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'In ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'In ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else if (difference.inSeconds > 0) {
      return 'Starting soon';
    } else {
      return 'Started';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime dateTime) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Get display date (Today, Tomorrow, Yesterday, or formatted date)
  static String getDisplayDate(DateTime dateTime) {
    if (isToday(dateTime)) {
      return 'Today';
    } else if (isTomorrow(dateTime)) {
      return 'Tomorrow';
    } else if (isYesterday(dateTime)) {
      return 'Yesterday';
    } else {
      return formatDate(dateTime);
    }
  }

  /// Get duration between two DateTime objects
  static String getDuration(DateTime start, DateTime end) {
    final difference = end.difference(start);
    
    if (difference.inHours > 0) {
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      if (minutes > 0) {
        return '${hours}h ${minutes}m';
      } else {
        return '${hours}h';
      }
    } else {
      return '${difference.inMinutes}m';
    }
  }

  /// Check if two DateTime objects are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Get start of day
  static DateTime getStartOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Get end of day
  static DateTime getEndOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);
  }
}

/// Extension for TimeOfDay
extension TimeOfDayExtensions on TimeOfDay {
  /// Convert TimeOfDay to DateTime (today)
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  /// Format TimeOfDay for display
  String format() {
    return DateFormat(DateTimeUtils.displayTimeFormat).format(toDateTime());
  }
}
