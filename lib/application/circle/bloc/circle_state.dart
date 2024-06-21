part of 'circle_bloc.dart';

final class CircleState extends VyfBaseState {
  const CircleState({
    this.status = StatusIndicator.initial,
    this.circle = Circle.empty,
  });

  final Circle circle;
  final StatusIndicator status;

  @override
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
  CircleState reset() => const CircleState();

  @override
  List<Object> get props => [
    circle,
    status,
  ];
}
