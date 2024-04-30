part of 'user_x_cubit.dart';

final class UserXState extends Equatable {
  const UserXState({
    this.status = StatusIndicator.initial,
    this.user = User.empty,
  });

  final User user;
  final StatusIndicator status;

  UserXState copyWith({
    User? user,
    StatusIndicator? status,
  }) {
    return UserXState(
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