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
