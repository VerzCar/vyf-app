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
    required this.currentCircleId,
  });

  final int circleId;
  final int currentCircleId;

  @override
  List<Object> get props => [
        circleId,
        currentCircleId,
      ];
}

final class CircleMembersStartCandidateChangedEvent extends MembersEvent {
  const CircleMembersStartCandidateChangedEvent({
    required this.currentUserIdentityId,
  });

  final String currentUserIdentityId;

  @override
  List<Object> get props => [
        currentUserIdentityId,
      ];
}

final class CircleMembersStartVoterChangedEvent extends MembersEvent {
  const CircleMembersStartVoterChangedEvent({
    required this.currentUserIdentityId,
  });

  final String currentUserIdentityId;

  @override
  List<Object> get props => [
        currentUserIdentityId,
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
    required this.currentCircleId,
  });

  final String candidateIdentId;
  final int currentCircleId;

  @override
  List<Object> get props => [
        candidateIdentId,
        currentCircleId,
      ];
}

final class CircleMembersRemovedVoterFromCircle extends MembersEvent {
  const CircleMembersRemovedVoterFromCircle({
    required this.voterIdentId,
    required this.currentCircleId,
  });

  final String voterIdentId;
  final int currentCircleId;

  @override
  List<Object> get props => [
        voterIdentId,
        currentCircleId,
      ];
}
