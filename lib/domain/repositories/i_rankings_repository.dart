import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/domain/models/models.dart' as entities;

abstract class IRankingsRepository {
  List<Future<entities.Placement>> rankingsToPlacements(List<Ranking> rankings);
}
