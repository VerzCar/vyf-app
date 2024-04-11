import 'package:equatable/equatable.dart';

class Locale extends Equatable {
  Locale({
    required this.id,
    required this.lcidString,
    required this.languageCode,
  });

  final int id;
  final String lcidString;
  final String languageCode;

  @override
  List<Object> get props => [
        id,
        lcidString,
        languageCode,
      ];
}
