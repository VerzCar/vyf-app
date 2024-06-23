part of 'rankings_cubit.dart';

final class RankingsState extends Equatable {
  const RankingsState({
    this.status = StatusIndicator.initial,
    this.circles = const [],
  });

  final List<Circle> circles;
  final StatusIndicator status;

  RankingsState copyWith({
    List<Circle>? circles,
    StatusIndicator? status,
  }) {
    return RankingsState(
      circles: circles ?? this.circles,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        circles,
      ];
}
