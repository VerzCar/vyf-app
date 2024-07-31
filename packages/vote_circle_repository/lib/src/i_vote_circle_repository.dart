import 'dart:typed_data';

import 'models/models.dart';

abstract class IVoteCircleRepository {
  Future<Circle> circle(int id);

  Future<List<Circle>> circles();

  Future<List<CirclePaginated>> circlesOfInterest();

  Future<List<CirclePaginated>> circlesFiltered({required String name});

  Future<List<CirclePaginated>> circlesOpenCommitments();

  Future<List<Ranking>> rankings(int circleId);

  Future<List<RankingLastViewed>> rankingsLastViewed();

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

  Future<String> removeCandidateFromCircle(
    int circleId,
    CandidateRequest candidateRequest,
  );

  Future<String> removeVoterFromCircle(
    int circleId,
    VoterRequest voterRequest,
  );

  Future<bool> createVote(
    int circleId,
    VoteCreateRequest voteCreateRequest,
  );

  Future<bool> revokeVote(int circleId);

  Future<UserOption> userOption();

  Future<List<String>> circleCandidateVotedBy(
    int circleId,
    CandidateRequest candidateRequest,
  );

  Future<Commitment> updateCommitment(
    int circleId,
    CircleCandidateCommitmentRequest commitmentRequest,
  );

  Future<String> uploadCircleImage(
    int circleId,
    Uint8List imageBytes,
  );

  Future<void> subscribeToCircleCandidateChangedEvent(int circleId);

  Future<void> subscribeToCircleVoterChangedEvent(int circleId);

  Stream<CircleCandidateChangeEvent> get watchCircleCandidateChangedEvent;

  Stream<CircleVoterChangeEvent> get watchCircleVoterChangedEvent;

  void dispose();
}
