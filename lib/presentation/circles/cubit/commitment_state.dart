part of 'commitment_cubit.dart';

enum CommitmentStatus {
  initial,
  committedLoading,
  rejectedLoading,
  committedSuccess,
  rejectedSuccess,
  failure,
}

extension CommitmentStatusX on CommitmentStatus {
  bool get isInitial => this == CommitmentStatus.initial;

  bool get isCommitmentLoading => this == CommitmentStatus.committedLoading;

  bool get isRejectionLoading => this == CommitmentStatus.rejectedLoading;

  bool get isCommitmentSuccessful => this == CommitmentStatus.committedSuccess;

  bool get isRejectionSuccessful => this == CommitmentStatus.rejectedSuccess;

  bool get isFailure => this == CommitmentStatus.failure;
}

final class CommitmentState extends Equatable {
  const CommitmentState({
    this.status = CommitmentStatus.initial,
  });

  final CommitmentStatus status;

  CommitmentState copyWith({
    CommitmentStatus? status,
  }) {
    return CommitmentState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
