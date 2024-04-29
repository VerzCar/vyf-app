part of 'user_avatar_cubit.dart';

extension UserAvatarStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

final class UserAvatarState extends Equatable {
  const UserAvatarState({
    this.status = StatusIndicator.initial,
    this.user = User.empty,
  });

  final User user;
  final StatusIndicator status;

  UserAvatarState copyWith({
    User? user,
    StatusIndicator? status,
  }) {
    return UserAvatarState(
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
