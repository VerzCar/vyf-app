part of 'circles_bloc.dart';

extension CirclesStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

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
