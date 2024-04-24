import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/domain/models/models.dart' as entities;
import 'package:vote_your_face/domain/repositories/i_rankings_repository.dart';

class RankingsRepository implements IRankingsRepository {
  RankingsRepository({required IUserRepository userRepository})
      : _userRepository = userRepository;

  final IUserRepository _userRepository;

  @override
  List<Future<entities.Placement>> rankingsToPlacements(
      List<Ranking> rankings) {
    return rankings
        .map((ranking) => _userRepository
            .x(ranking.identityId)
            .then((user) => entities.Placement(user: user, ranking: ranking)))
        .toList();
  }
}
