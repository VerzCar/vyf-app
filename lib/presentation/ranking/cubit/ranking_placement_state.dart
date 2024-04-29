part of 'ranking_placement_cubit.dart';

final class RankingPlacementState extends Equatable {
  const RankingPlacementState({
    this.status = StatusIndicator.initial,
    this.user = User.empty,
  });

  final User user;
  final StatusIndicator status;

  RankingPlacementState copyWith({
    User? user,
    StatusIndicator? status,
  }) {
    return RankingPlacementState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        user,
        status,
      ];
}
