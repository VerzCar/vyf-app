part of 'circle_bloc.dart';

final class CircleState extends Equatable {
  const CircleState({
    this.status = StatusIndicator.initial,
    this.circle = Circle.empty,
  });

  final Circle circle;
  final StatusIndicator status;

  CircleState copyWith({
    Circle? circle,
    StatusIndicator? status,
  }) {
    return CircleState(
      circle: circle ?? this.circle,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
    circle,
    status,
  ];
}
