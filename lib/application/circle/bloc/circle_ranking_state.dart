part of 'circle_ranking_bloc.dart';

final class CircleRankingState extends VyfBaseState {
  const CircleRankingState({
    this.status = StatusIndicator.initial,
    this.circle = Circle.empty,
  });

  final Circle circle;
  final StatusIndicator status;

  @override
  CircleRankingState copyWith({
    Circle? circle,
    StatusIndicator? status,
  }) {
    return CircleRankingState(
      circle: circle ?? this.circle,
      status: status ?? this.status,
    );
  }

  @override
  CircleRankingState reset() => const CircleRankingState();

  @override
  List<Object> get props => [
    circle,
    status,
  ];
}
