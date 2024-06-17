part of 'circles_of_interest_cubit.dart';

final class CirclesOfInterestState extends Equatable {
  const CirclesOfInterestState({
    this.status = StatusIndicator.initial,
    this.circlesOfInterest = const [],
  });

  final List<CirclePaginated> circlesOfInterest;
  final StatusIndicator status;

  CirclesOfInterestState copyWith({
    List<CirclePaginated>? circlesOfInterest,
    StatusIndicator? status,
  }) {
    return CirclesOfInterestState(
      circlesOfInterest: circlesOfInterest ?? this.circlesOfInterest,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        circlesOfInterest,
        status,
      ];
}
