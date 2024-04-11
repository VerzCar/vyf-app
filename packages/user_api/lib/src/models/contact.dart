import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  Contact({
    required this.id,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.web,
    required this.email,
  });

  final int id;
  final String email;
  final String phoneNumber;
  final String phoneNumber2;
  final String web;

  @override
  List<Object> get props => [
        id,
        email,
        phoneNumber,
        phoneNumber2,
        web,
      ];
}
