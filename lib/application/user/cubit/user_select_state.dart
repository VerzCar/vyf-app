part of 'user_select_cubit.dart';

final class UserSelectState extends Equatable {
  const UserSelectState({
    this.status = StatusIndicator.initial,
    this.selectedUsers = const [],
  });

  final StatusIndicator status;
  final List<SelectedUser> selectedUsers;

  UserSelectState copyWith({
    StatusIndicator? status,
    List<SelectedUser>? selectedUsers,
  }) {
    return UserSelectState(
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
