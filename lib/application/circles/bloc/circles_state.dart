part of 'circles_bloc.dart';

final class CirclesState extends Equatable {
  const CirclesState({
    this.status = StatusIndicator.initial,
    this.myCircles = const [],
  });

  final List<Circle> myCircles;
  final StatusIndicator status;

  CirclesState copyWith({
    List<Circle>? myCircles,
    StatusIndicator? status,
  }) {
    return CirclesState(
      myCircles: myCircles ?? this.myCircles,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        myCircles,
        status,
      ];
}
