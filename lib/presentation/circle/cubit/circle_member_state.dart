part of 'circle_member_cubit.dart';

extension CircleMemberStateStatus on StatusIndicator {
  bool get isInitial => this == StatusIndicator.initial;

  bool get isLoading => this == StatusIndicator.loading;

  bool get isSuccessful => this == StatusIndicator.success;

  bool get isFailure => this == StatusIndicator.failure;
}

final class CircleMemberState extends Equatable {
  const CircleMemberState({
    this.status = StatusIndicator.initial,
  });

  final StatusIndicator status;

  CircleMemberState copyWith({
    StatusIndicator? status,
  }) {
    return CircleMemberState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
