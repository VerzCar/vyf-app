part of 'circles_bloc.dart';

sealed class CirclesEvent extends Equatable {
  const CirclesEvent();
}

final class CirclesOfUserInitialLoaded extends CirclesEvent {
  @override
  List<Object> get props => [];
}

final class CirclesOfInterestInitialLoaded extends CirclesEvent {
  @override
  List<Object> get props => [];
}
