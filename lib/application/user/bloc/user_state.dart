part of 'user_bloc.dart';

final class UserState extends Equatable {
  const UserState({
    this.status = StatusIndicator.initial,
    this.user = User.empty,
  });

  final User user;
  final StatusIndicator status;

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
  List<Object> get props => [
        user,
        status,
      ];
}
