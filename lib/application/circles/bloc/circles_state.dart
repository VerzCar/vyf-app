part of 'circles_bloc.dart';

final class CirclesState extends Equatable {
  const CirclesState({
    this.status = StatusIndicator.initial,
    this.myCircles = const [],
    this.circlesOfInterest = const [],
  });

  final List<Circle> myCircles;
  final List<CirclePaginated> circlesOfInterest;
  final StatusIndicator status;

  CirclesState copyWith({
    List<Circle>? myCircles,
    List<CirclePaginated>? circlesOfInterest,
    StatusIndicator? status,
  }) {
    return CirclesState(
      myCircles: myCircles ?? this.myCircles,
      circlesOfInterest: circlesOfInterest ?? this.circlesOfInterest,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        myCircles,
        circlesOfInterest,
        status,
      ];
}
