import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';

class Placement {
  final User user;
  final Ranking ranking;

  Placement({
    required this.user,
    required this.ranking,
  });
}
