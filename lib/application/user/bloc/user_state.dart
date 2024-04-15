part of 'user_bloc.dart';

enum StatusIndicator { initial, loading, success, failure }

extension UserStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

final class UserState extends Equatable {
  const UserState({
    this.state = StatusIndicator.initial,
    required this.user,
  })

  final User user;
  final StatusIndicator state;

  @override
  List<Object> get props => [user,];
}

// sealed class UserEvent {}
//
// final class UserInitialLoaded extends UserEvent {}
//
// class UserBloc extends Bloc<UserEvent, int> {
//   UserBloc() : super(0);
// }