part of 'circle_member_cubit.dart';

enum CircleMemberStateStatus {
  initial,
  loadingCandidate,
  loadingVoter,
  successCandidate,
  successVoter,
  failureCandidate,
  failureVoter,
}

extension CircleMemberStateStatusX on CircleMemberStateStatus {
  bool get isInitial => this == CircleMemberStateStatus.initial;

  bool get isCandidateActionLoading =>
      this == CircleMemberStateStatus.loadingCandidate;

  bool get isVoterActionLoading => this == CircleMemberStateStatus.loadingVoter;

  bool get isCandidateActionSuccessful =>
      this == CircleMemberStateStatus.successCandidate;

  bool get isVoterActionSuccessful =>
      this == CircleMemberStateStatus.successVoter;

  bool get isCandidateActionFailure =>
      this == CircleMemberStateStatus.failureCandidate;

  bool get isVoterActionFailure => this == CircleMemberStateStatus.failureVoter;
}

final class CircleMemberState extends Equatable {
  const CircleMemberState({
    this.status = CircleMemberStateStatus.initial,
  });

  final CircleMemberStateStatus status;

  CircleMemberState copyWith({
    CircleMemberStateStatus? status,
  }) {
    return CircleMemberState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
