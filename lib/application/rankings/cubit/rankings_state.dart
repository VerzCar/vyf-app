part of 'rankings_cubit.dart';

final class RankingsState extends Equatable {
  const RankingsState({
    this.status = StatusIndicator.initial,
    this.lastViewed = const [],
  });

  final List<RankingLastViewed> lastViewed;
  final StatusIndicator status;

  RankingsState copyWith({
    List<RankingLastViewed>? lastViewed,
    StatusIndicator? status,
  }) {
    return RankingsState(
      lastViewed: lastViewed ?? this.lastViewed,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        lastViewed,
      ];
}
