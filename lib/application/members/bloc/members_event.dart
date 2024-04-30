part of 'members_bloc.dart';

sealed class MembersEvent extends Equatable {
  const MembersEvent();
}

final class MembersInitialLoaded extends MembersEvent {
  const MembersInitialLoaded({required this.circleId});

  final int circleId;

  @override
  List<Object> get props => [];
}
