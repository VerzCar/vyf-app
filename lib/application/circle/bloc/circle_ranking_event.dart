part of 'circle_ranking_bloc.dart';

abstract class CircleRankingEvent extends Equatable {
  const CircleRankingEvent();
}

final class CircleRankingSelected extends CircleRankingEvent {
  const CircleRankingSelected({required this.circleId});

  final int circleId;

  @override
  List<Object> get props => [circleId];
}

final class CircleRankingUpdated extends CircleRankingEvent {
  const CircleRankingUpdated({required this.circle});

  final Circle circle;

  @override
  List<Object> get props => [circle];
}