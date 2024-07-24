part of 'vote_cubit.dart';

enum VoteStatus {
  initial,
  loading,
  voteSuccess,
  revokedSuccess,
  failure,
}

final class VoteState extends Equatable {
  const VoteState({
    this.status = VoteStatus.initial,
  });

  final VoteStatus status;

  VoteState copyWith({
    VoteStatus? status,
  }) {
    return VoteState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
