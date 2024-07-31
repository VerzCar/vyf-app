part of 'circle_bloc.dart';

abstract class CircleEvent extends Equatable {
  const CircleEvent();
}

final class CircleSelected extends CircleEvent {
  const CircleSelected({required this.circleId});

  final int circleId;

  @override
  List<Object> get props => [circleId];
}

final class CircleUpdated extends CircleEvent {
  const CircleUpdated({required this.circle});

  final Circle circle;

  @override
  List<Object> get props => [circle];
}

final class CircleImageUpdated extends CircleEvent {
  const CircleImageUpdated({required this.imageSrc});

  final String imageSrc;

  @override
  List<Object> get props => [imageSrc];
}
