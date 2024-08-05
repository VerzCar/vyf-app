part of 'ranking_item_cubit.dart';

final class RankingItemState extends Equatable {
  const RankingItemState({
    this.status = StatusIndicator.initial,
    this.votedByIds = const [],
  });

  final StatusIndicator status;
  final List<String> votedByIds;

  RankingItemState copyWith({
    List<String>? votedByIds,
    StatusIndicator? status,
  }) {
    return RankingItemState(
      votedByIds: votedByIds ?? this.votedByIds,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        votedByIds,
      ];
}
