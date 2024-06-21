part of 'user_bloc.dart';

final class UserState extends VyfBaseState  {
  const UserState({
    this.status = StatusIndicator.initial,
    this.user = User.empty,
  });

  final User user;
  final StatusIndicator status;

  @override
  UserState copyWith({
    User? user,
    StatusIndicator? status,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  UserState reset() => const UserState();

  @override
  List<Object> get props => [
        user,
        status,
      ];
}
