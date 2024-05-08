part of 'members_bloc.dart';

extension MembersStateStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

final class MembersState extends Equatable {
  const MembersState({
    this.status = StatusIndicator.initial,
    this.circleVoter = CircleVoter.empty,
    this.circleCandidate = CircleCandidate.empty,
    this.rankingVoter = CircleVoter.empty,
    this.rankingCandidate = CircleCandidate.empty,
    this.circleRefId = 0,
    this.circleRankingsRefId = 0,
  });

  final CircleVoter circleVoter;
  final CircleCandidate circleCandidate;
  final CircleVoter rankingVoter;
  final CircleCandidate rankingCandidate;

  // the members for this reference of circle id
  final int circleRefId;
  final int circleRankingsRefId;
  final StatusIndicator status;

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
      rankingVoter: rankingVoter ?? this.rankingVoter,
      rankingCandidate: rankingCandidate ?? this.rankingCandidate,
      circleRefId: circleRefId ?? this.circleRefId,
      circleRankingsRefId: circleRankingsRefId ?? this.circleRankingsRefId,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        circleVoter,
        circleCandidate,
        rankingVoter,
        rankingCandidate,
        circleRefId,
        circleRankingsRefId,
        status,
      ];
}
