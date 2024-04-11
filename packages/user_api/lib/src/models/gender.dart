import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue('X')
  X,
  @JsonValue('MAN')
  Man,
  @JsonValue('WOMEN')
  Women,
}

// Helper function to convert enum to string
String genderToString(Gender gender) {
  switch (gender) {
    case Gender.X:
      return 'X';
    case Gender.Man:
      return 'MAN';
    case Gender.Women:
      return 'WOMEN';
    default:
      return '';
  }
}

// Helper function to convert string to enum
Gender stringToGender(String gender) {
  switch (gender) {
    case 'X':
      return Gender.X;
    case 'MAN':
      return Gender.Man;
    case 'WOMEN':
      return Gender.Women;
    default:
      throw ArgumentError('Invalid gender string');
  }
}
