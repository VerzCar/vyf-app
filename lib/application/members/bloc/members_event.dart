part of 'members_bloc.dart';

sealed class MembersEvent extends Equatable {
  const MembersEvent();
}

final class MembersInitialLoaded extends MembersEvent {
  const MembersInitialLoaded({
    required this.circleId,
    required this.currentCircleId,
    this.filter,
  });

  final int circleId;
  final int currentCircleId;
  final CircleCandidatesFilter? filter;

  @override
  List<Object?> get props => [
        circleId,
        currentCircleId,
        filter,
      ];
}

final class MembersStartCandidateChangedEvent extends MembersEvent {
  const MembersStartCandidateChangedEvent({
    required this.currentUserIdentityId,
  });

  final String currentUserIdentityId;

  @override
  List<Object> get props => [
        currentUserIdentityId,
      ];
}

final class MembersStartVoterChangedEvent extends MembersEvent {
  const MembersStartVoterChangedEvent({
    required this.currentUserIdentityId,
  });

  final String currentUserIdentityId;

  @override
  List<Object> get props => [
        currentUserIdentityId,
      ];
}

final class MembersRemovedCandidateFromCircle extends MembersEvent {
  const MembersRemovedCandidateFromCircle({
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

final class MembersRemovedVoterFromCircle extends MembersEvent {
  const MembersRemovedVoterFromCircle({
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
