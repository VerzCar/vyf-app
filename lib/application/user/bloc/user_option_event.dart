part of 'user_option_bloc.dart';

sealed class UserOptionEvent extends Equatable {
  const UserOptionEvent();
}

final class UserOptionReset extends UserOptionEvent {
  @override
  List<Object> get props => [];
}

final class UserOptionLoaded extends UserOptionEvent {
  @override
  List<Object> get props => [];
}
