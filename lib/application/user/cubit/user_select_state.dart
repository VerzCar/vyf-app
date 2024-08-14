part of 'user_select_cubit.dart';

final class UserSelectState extends Equatable {
  const UserSelectState({
    this.status = StatusIndicator.initial,
    this.searchResults = const [],
    this.selectedUsers = const [],
  });

  final StatusIndicator status;

  /// Users that are currently selected.
  /// Use this property to get all currently selected users.
  final List<SelectedUser> selectedUsers;

  /// All users from the current request. With the corresponding
  /// selected state. Use this property for list view.
  final List<SelectedUser> searchResults;

  UserSelectState copyWith({
    StatusIndicator? status,
    List<SelectedUser>? selectedUsers,
    List<SelectedUser>? searchResults,
  }) {
    return UserSelectState(
      status: status ?? this.status,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object> get props => [
        status,
        selectedUsers,
        searchResults,
      ];
}
