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

final class CircleMembersCandidateChanged extends MembersEvent {
  const CircleMembersCandidateChanged({
    required this.changeEvent,
  });

  final CircleCandidateChangeEvent changeEvent;

  @override
  List<Object> get props => [
        changeEvent,
      ];
}

final class CircleMembersVoterChanged extends MembersEvent {
  const CircleMembersVoterChanged({
    required this.changeEvent,
  });

  final CircleVoterChangeEvent changeEvent;

  @override
  List<Object> get props => [
        changeEvent,
      ];
}

final class CircleMembersRemovedCandidateFromCircle extends MembersEvent {
  const CircleMembersRemovedCandidateFromCircle({
    required this.candidateIdentId,
    required this.context,
  });

  final String candidateIdentId;
  final BuildContext context;

  @override
  List<Object> get props => [
        candidateIdentId,
        context,
      ];
}

final class CircleMembersRemovedVoterFromCircle extends MembersEvent {
  const CircleMembersRemovedVoterFromCircle({
    required this.voterIdentId,
    required this.context,
  });

  final String voterIdentId;
  final BuildContext context;

  @override
  List<Object> get props => [
    voterIdentId,
    context,
  ];
}
