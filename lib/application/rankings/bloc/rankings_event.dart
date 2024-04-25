part of 'rankings_bloc.dart';

abstract class RankingsEvent extends Equatable {
  const RankingsEvent();
}

final class RankingCircleSelected extends RankingsEvent {
  const RankingCircleSelected({this.circleId});

  final int? circleId;

  @override
  List<Object?> get props => [circleId];
}

final class CircleForRankingsDefined extends RankingsEvent {
  const CircleForRankingsDefined({required this.circleId});

  final int circleId;

  @override
  List<Object> get props => [circleId];
}
