part of 'circles_bloc.dart';

final class CirclesState extends VyfBaseState {
  const CirclesState({
    this.status = StatusIndicator.initial,
    this.myCircles = const [],
    this.circlesOfInterest = const [],
    this.circlesOpenCommitments = const [],
  });

  final List<Circle> myCircles;
  final List<CirclePaginated> circlesOfInterest;
  final List<CirclePaginated> circlesOpenCommitments;
  final StatusIndicator status;

  @override
  CirclesState copyWith({
    List<Circle>? myCircles,
    List<CirclePaginated>? circlesOfInterest,
    List<CirclePaginated>? circlesOpenCommitments,
    StatusIndicator? status,
  }) {
    return CirclesState(
      myCircles: myCircles ?? this.myCircles,
      circlesOfInterest: circlesOfInterest ?? this.circlesOfInterest,
      circlesOpenCommitments:
          circlesOpenCommitments ?? this.circlesOpenCommitments,
      status: status ?? this.status,
    );
  }

  @override
  CirclesState reset() => const CirclesState();

  @override
  List<Object> get props => [
        myCircles,
        circlesOfInterest,
        circlesOpenCommitments,
        status,
      ];
}
