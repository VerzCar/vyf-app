import 'models/models.dart';

abstract class IVoteCircleApiClient {
  Future<Circle> fetchCircle(int id);

  Future<List<Circle>> fetchCircles();

  Future<List<CirclePaginated>> fetchCirclesOfInterest();

  Future<List<Ranking>> fetchRankings(int circleId);

  Future<CircleVoter> fetchCircleVoters(int circleId);

  Future<CircleCandidate> fetchCircleCandidates(
    int circleId,
    CircleCandidatesFilter? filter,
  );

  Future<Circle> createCircle(CircleCreateRequest circleRequest);

  Future<Circle> updateCircle(
    int circleId,
    CircleUpdateRequest circleUpdateRequest,
  );

  Future<void> deleteCircle(int circleId);
}
