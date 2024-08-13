import 'package:user_repository/user_repository.dart';

class SelectedUser {
  const SelectedUser({
    required this.user,
    required this.selected,
  });

  final UserPaginated user;
  final bool selected;
}
