part of 'rankings_cubit.dart';

extension RankingsStateStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

final class RankingsState extends Equatable {
  const RankingsState({
    this.status = StatusIndicator.initial,
    this.rankings = const [],
  });

  final List<Ranking> rankings;
  final StatusIndicator status;

  RankingsState copyWith({
    List<Ranking>? rankings,
    StatusIndicator? status,
  }) {
    return RankingsState(
      rankings: rankings ?? this.rankings,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, rankings];
}
