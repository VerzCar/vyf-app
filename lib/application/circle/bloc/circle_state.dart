part of 'circle_bloc.dart';

extension CircleStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

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
