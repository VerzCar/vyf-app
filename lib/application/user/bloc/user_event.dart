part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

final class UserInitialLoaded extends UserEvent {
  @override
  List<Object> get props => [];
}
