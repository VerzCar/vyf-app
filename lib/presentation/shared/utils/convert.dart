String usersInitials(String username) {
  final initials = username.substring(0, 2);
  return initials[0] + initials[1];
}
