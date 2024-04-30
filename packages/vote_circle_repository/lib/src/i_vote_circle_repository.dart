import 'models/models.dart';

abstract class IVoteCircleRepository {
  Future<Circle> circle(int id);

  Future<List<Circle>> circles();

  Future<List<CirclePaginated>> circlesOfInterest();

  Future<List<Ranking>> rankings(int circleId);

  Future<List<CircleVoter>> circleVoters(int circleId);

  Future<List<CircleCandidate>> circleCandidates(int circleId);
}
