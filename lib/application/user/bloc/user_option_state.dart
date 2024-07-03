part of 'user_option_bloc.dart';

final class UserOptionState extends VyfBaseState {
  const UserOptionState({
    this.status = StatusIndicator.initial,
    this.userOption = UserOption.empty,
  });

  final UserOption userOption;
  final StatusIndicator status;

  @override
  UserOptionState copyWith({
    UserOption? userOption,
    StatusIndicator? status,
  }) {
    return UserOptionState(
      userOption: userOption ?? this.userOption,
      status: status ?? this.status,
    );
  }

  @override
  UserOptionState reset() => const UserOptionState();

  @override
  List<Object> get props => [
        userOption,
        status,
      ];
}
