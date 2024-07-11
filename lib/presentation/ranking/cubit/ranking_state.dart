part of 'ranking_cubit.dart';

final class RankingState extends Equatable {
  const RankingState({
    this.status = StatusIndicator.initial,
    this.rankings = const [],
    this.topRankings = const [],
  });

  final List<Ranking> rankings;
  final List<Ranking> topRankings;
  final StatusIndicator status;

  RankingState copyWith({
    List<Ranking>? rankings,
    List<Ranking>? topRankings,
    StatusIndicator? status,
  }) {
    return RankingState(
      rankings: rankings ?? this.rankings,
      topRankings: topRankings ?? this.topRankings,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        rankings,
        topRankings,
      ];
}
