import 'package:user_api/user_api.dart' as user_api;

enum Gender {
  X,
  Man,
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

Gender genderFromApiGender(user_api.Gender gender) {
  switch(gender) {
    case user_api.Gender.X:
      return Gender.X;
    case user_api.Gender.Women:
      return Gender.Women;
    case user_api.Gender.Man:
      return Gender.Man;
  }
}
