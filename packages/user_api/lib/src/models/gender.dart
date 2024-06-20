import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue('X')
  x,
  @JsonValue('MAN')
  man,
  @JsonValue('WOMEN')
  women,
}

// Helper function to convert enum to string
String genderToString(Gender gender) {
  switch (gender) {
    case Gender.x:
      return 'X';
    case Gender.man:
      return 'MAN';
    case Gender.women:
      return 'WOMEN';
    default:
      return '';
  }
}

// Helper function to convert string to enum
Gender stringToGender(String gender) {
  switch (gender) {
    case 'X':
      return Gender.x;
    case 'MAN':
      return Gender.man;
    case 'WOMEN':
      return Gender.women;
    default:
      throw ArgumentError('Invalid gender string');
  }
}
