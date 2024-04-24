part of 'rankings_bloc.dart';

extension RankingsStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

final class RankingsState extends Equatable {
  const RankingsState({
    this.status = StatusIndicator.initial,
    this.selectedCircle,
    this.placements = const [],
  });

  final Circle? selectedCircle;
  final List<entities.Placement> placements;
  final StatusIndicator status;

  RankingsState copyWith({
    Circle? selectedCircle,
    List<entities.Placement>? placements,
    StatusIndicator? status,
  }) {
    return RankingsState(
      selectedCircle: selectedCircle ?? this.selectedCircle,
      placements: placements ?? this.placements,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}
