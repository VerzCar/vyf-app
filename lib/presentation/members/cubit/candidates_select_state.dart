part of 'candidates_select_cubit.dart';

final class CandidatesSelectState extends Equatable {
  const CandidatesSelectState({
    this.status = StatusIndicator.initial,
    this.selectedUsers = const [],
  });

  final StatusIndicator status;
  final List<SelectedUser> selectedUsers;

  CandidatesSelectState copyWith({
    StatusIndicator? status,
    List<SelectedUser>? selectedUsers,
  }) {
    return CandidatesSelectState(
      status: status ?? this.status,
      selectedUsers: selectedUsers ?? this.selectedUsers,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedUsers,
      ];
}
