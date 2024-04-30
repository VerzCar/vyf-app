import 'models/models.dart';

abstract class IVoteCircleApiClient {
  Future<Circle> fetchCircle(int id);

  Future<List<Circle>> fetchCircles();

  Future<List<CirclePaginated>> fetchCirclesOfInterest();

  Future<List<Ranking>> fetchRankings(int circleId);

  Future<List<CircleVoter>> fetchCircleVoters(int circleId);

  Future<List<CircleCandidate>> fetchCircleCandidates(int circleId);
}
