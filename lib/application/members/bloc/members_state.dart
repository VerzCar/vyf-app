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
  });

  final CircleVoter circleVoter;
  final CircleCandidate circleCandidate;
  final StatusIndicator status;

  MembersState copyWith({
    CircleVoter? circleVoter,
    CircleCandidate? circleCandidate,
    StatusIndicator? status,
  }) {
    return MembersState(
      circleVoter: circleVoter ?? this.circleVoter,
      circleCandidate: circleCandidate ?? this.circleCandidate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        circleVoter,
        circleCandidate,
        status,
      ];
}
