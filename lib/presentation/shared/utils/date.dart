extension DateCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }

  bool isSameTime(DateTime other) {
    return hour == other.hour && minute == other.minute
        && second == other.second;
  }
}
