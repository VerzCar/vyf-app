part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class UserInitialLoaded extends UserEvent {
  @override
  List<Object> get props => [];
}

final class UserUpdated extends UserEvent {
  const UserUpdated({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}