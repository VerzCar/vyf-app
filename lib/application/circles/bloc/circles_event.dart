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
