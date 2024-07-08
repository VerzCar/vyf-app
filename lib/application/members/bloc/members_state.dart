part of 'members_bloc.dart';

final class MembersState extends VyfBaseState {
  const MembersState({
    this.status = StatusIndicator.initial,
    this.circleVoter = CircleVoter.empty,
    this.circleCandidate = CircleCandidate.empty,
    this.circleRefId = 0,
  });

  final CircleVoter circleVoter;
  final CircleCandidate circleCandidate;

  // the members for this reference of circle id
  final int circleRefId;
  final StatusIndicator status;

  @override
  MembersState copyWith({
    CircleVoter? circleVoter,
    CircleCandidate? circleCandidate,
    CircleVoter? rankingVoter,
    CircleCandidate? rankingCandidate,
    int? circleRefId,
    int? circleRankingsRefId,
    StatusIndicator? status,
  }) {
    return MembersState(
      circleVoter: circleVoter ?? this.circleVoter,
      circleCandidate: circleCandidate ?? this.circleCandidate,
      circleRefId: circleRefId ?? this.circleRefId,
      status: status ?? this.status,
    );
  }

  @override
  MembersState reset() => const MembersState();

  @override
  List<Object> get props => [
        circleVoter,
        circleCandidate,
        circleRefId,
        status,
      ];
}
