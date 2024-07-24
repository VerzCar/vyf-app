part of 'circles_bloc.dart';

sealed class CirclesEvent extends Equatable {
  const CirclesEvent();
}

final class CirclesOfUserInitialLoaded extends CirclesEvent {
  @override
  List<Object> get props => [];
}

final class CircleCreated extends CirclesEvent {
  const CircleCreated({required this.circle});

  final Circle circle;

  @override
  List<Object> get props => [circle];
}

final class CircleUpdated extends CirclesEvent {
  const CircleUpdated({required this.circle});

  final Circle circle;

  @override
  List<Object> get props => [circle];
}

final class CircleDeleted extends CirclesEvent {
  const CircleDeleted({required this.circleId});

  final int circleId;

  @override
  List<Object> get props => [circleId];
}

final class CirclesWithOpenCommitmentsLoaded extends CirclesEvent {
  @override
  List<Object> get props => [];
}
