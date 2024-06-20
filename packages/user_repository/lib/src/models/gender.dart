import 'package:user_api/user_api.dart' as user_api;

enum Gender {
  x,
  man,
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

Gender genderFromApiGender(user_api.Gender gender) {
  switch (gender) {
    case user_api.Gender.x:
      return Gender.x;
    case user_api.Gender.women:
      return Gender.women;
    case user_api.Gender.man:
      return Gender.man;
  }
}
