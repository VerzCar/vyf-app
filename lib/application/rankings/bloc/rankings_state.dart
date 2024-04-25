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
    this.rankings = const [],
  });

  final Circle? selectedCircle;
  final List<Ranking> rankings;
  final StatusIndicator status;

  RankingsState copyWith({
    Circle? selectedCircle,
    List<Ranking>? rankings,
    StatusIndicator? status,
  }) {
    return RankingsState(
      selectedCircle: selectedCircle ?? this.selectedCircle,
      rankings: rankings ?? this.rankings,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}
