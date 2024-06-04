import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String dateTime) {
    return DateTime.parse(dateTime).toLocal();
  }

  @override
  String toJson(DateTime date) => date.toUtc().toIso8601String();
}
