part of 'members_bloc.dart';

sealed class MembersEvent extends Equatable {
  const MembersEvent();
}

final class CircleMembersReset extends MembersEvent {
  @override
  List<Object> get props => [];
}

final class CircleMembersInitialLoaded extends MembersEvent {
  const CircleMembersInitialLoaded({
    required this.circleId,
    required this.context,
  });

  final int circleId;
  final BuildContext context;

  @override
  List<Object> get props => [
        circleId,
      ];
}

final class RankingMembersInitialLoaded extends MembersEvent {
  const RankingMembersInitialLoaded({
    required this.circleId,
    required this.context,
  });

  final int circleId;
  final BuildContext context;

  @override
  List<Object> get props => [
        circleId,
      ];
}

final class CircleCandidateChanged extends MembersEvent {
  const CircleCandidateChanged({
    required this.changeEvent,
  });

  final CircleCandidateChangeEvent changeEvent;

  @override
  List<Object> get props => [
        changeEvent,
      ];
}

final class CircleVoterChanged extends MembersEvent {
  const CircleVoterChanged({
    required this.changeEvent,
  });

  final CircleVoterChangeEvent changeEvent;

  @override
  List<Object> get props => [
    changeEvent,
  ];
}
