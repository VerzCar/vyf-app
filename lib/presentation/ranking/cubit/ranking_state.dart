part of 'ranking_cubit.dart';

final class RankingState extends Equatable {
  const RankingState({
    this.status = StatusIndicator.initial,
    this.rankings = const [],
  });

  final List<Ranking> rankings;
  final StatusIndicator status;

  RankingState copyWith({
    List<Ranking>? rankings,
    StatusIndicator? status,
  }) {
    return RankingState(
      rankings: rankings ?? this.rankings,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        rankings,
      ];
}
