import 'models/models.dart';

abstract class IVoteCircleRepository {
  Future<Circle> circle(int id);

  Future<List<Circle>> circles();

  Future<List<CirclePaginated>> circlesOfInterest();

  Future<List<Ranking>> rankings(int circleId);

  Future<CircleVoter> circleVoters(int circleId);

  Future<CircleCandidate> circleCandidates(
    int circleId,
    CircleCandidatesFilter? filter,
  );

  Future<Circle> createCircle(CircleCreateRequest circleRequest);

  Future<Circle> updateCircle(
    int circleId,
    CircleUpdateRequest circleUpdateRequest,
  );

  Future<void> deleteCircle(
    int circleId,
  );

  Future<bool> eligibleToBeInCircle(int circleId);

  Future<Voter> joinCircleAsVoter(int circleId);

  Future<Candidate> joinCircleAsCandidate(int circleId);

  Future<String> leaveCircleAsVoter(int circleId);

  Future<String> leaveCircleAsCandidate(int circleId);

  void subscribeToCircleCandidateChangedEvent(int circleId);

  Stream<CircleCandidateChangeEvent> get circleCandidateChangedEvent;

  void dispose();
}
