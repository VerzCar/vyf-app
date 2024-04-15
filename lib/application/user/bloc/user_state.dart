part of 'user_bloc.dart';

extension UserStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

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
