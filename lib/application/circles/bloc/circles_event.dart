part of 'circles_bloc.dart';

sealed class CirclesEvent extends Equatable {
  const CirclesEvent();
}

final class CirclesOfUserInitialLoaded extends CirclesEvent {
  @override
  List<Object> get props => [];
}

final class CirclesCreated extends CirclesEvent {
  const CirclesCreated({required this.circle});

  final Circle circle;

  @override
  List<Object> get props => [circle];
}

final class CirclesUpdated extends CirclesEvent {
  const CirclesUpdated({required this.circle});

  final Circle circle;

  @override
  List<Object> get props => [circle];
}

final class CirclesDeleted extends CirclesEvent {
  const CirclesDeleted({required this.circleId});

  final int circleId;

  @override
  List<Object> get props => [circleId];
}

final class CirclesWithOpenCommitmentsLoaded extends CirclesEvent {
  @override
  List<Object> get props => [];
}
