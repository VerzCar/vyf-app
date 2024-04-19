part of 'circle_cubit.dart';

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
    this.owner = User.empty,
  });

  final Circle circle;
  final User owner;
  final StatusIndicator status;

  CircleState copyWith({
    Circle? circle,
    User? owner,
    StatusIndicator? status,
  }) {
    return CircleState(
      circle: circle ?? this.circle,
      owner: owner ?? this.owner,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        circle,
        owner,
        status,
      ];
}
