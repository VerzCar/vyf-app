part of 'vote_cubit.dart';

final class VoteState extends Equatable {
  const VoteState({
    this.status = StatusIndicator.initial,
  });

  final StatusIndicator status;

  VoteState copyWith({
    StatusIndicator? status,
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
