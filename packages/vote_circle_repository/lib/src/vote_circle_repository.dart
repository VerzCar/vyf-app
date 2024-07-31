import 'dart:async';
import 'dart:typed_data';
import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'i_vote_circle_repository.dart';
import 'models/models.dart';

class VoteCircleRepository implements IVoteCircleRepository {
  VoteCircleRepository({
    required IAuthenticationRepository authenticationRepository,
    vote_circle_api.IVoteCircleApiClient? voteCircleApi,
    IAblyServiceClient? ablyService,
  })  : _voteCircleApi = voteCircleApi ??
            vote_circle_api.VoteCircleApiClient(
              authenticationRepository: authenticationRepository,
            ),
        _ablyService = ablyService ??
            AblyServiceClient(
              authenticationRepository: authenticationRepository,
            );

  final vote_circle_api.IVoteCircleApiClient _voteCircleApi;
  final IAblyServiceClient _ablyService;
  final Logger log = Logger();
  final StreamController<CircleCandidateChangeEvent>
      _candidateChangedEventController =
      StreamController<CircleCandidateChangeEvent>.broadcast();
  StreamSubscription<CircleCandidateChangeEvent>?
      _candidateChangedEventSubscription;
  final StreamController<CircleVoterChangeEvent> _voterChangedEventController =
      StreamController<CircleVoterChangeEvent>.broadcast();
  StreamSubscription<CircleVoterChangeEvent>? _voterChangedEventSubscription;

  @override
  Future<Circle> circle(int id) async {
    final res = await _voteCircleApi.fetchCircle(id);
    return Circle.fromApiCircle(res);
  }

  @override
  Future<List<Circle>> circles() async {
    final res = await _voteCircleApi.fetchCircles();
    final circles = res.map((circle) => Circle.fromApiCircle(circle)).toList();
    return circles;
  }

  @override
  Future<List<CirclePaginated>> circlesOfInterest() async {
    final res = await _voteCircleApi.fetchCirclesOfInterest();
    final circles = res
        .map((circle) => CirclePaginated.fromApiCirclePaginated(circle))
        .toList();
    return circles;
  }

  @override
  Future<List<CirclePaginated>> circlesOpenCommitments() async {
    final res = await _voteCircleApi.fetchCirclesOpenCommitments();
    final circles = res
        .map((circle) => CirclePaginated.fromApiCirclePaginated(circle))
        .toList();
    return circles;
  }

  @override
  Future<List<CirclePaginated>> circlesFiltered({required String name}) async {
    final res = await _voteCircleApi.fetchCirclesFiltered(name: name);
    final circles = res
        .map((circle) => CirclePaginated.fromApiCirclePaginated(circle))
        .toList();
    return circles;
  }

  @override
  Future<List<Ranking>> rankings(int circleId) async {
    final res = await _voteCircleApi.fetchRankings(circleId);
    final rankings =
        res.map((ranking) => Ranking.fromApiRanking(ranking)).toList();
    return rankings;
  }

  @override
  Future<List<RankingLastViewed>> rankingsLastViewed() async {
    final res = await _voteCircleApi.fetchRankingsLastViewed();
    final rankings = res
        .map((ranking) => RankingLastViewed.fromApiRankingLastViewed(ranking))
        .toList();
    return rankings;
  }

  @override
  Future<CircleCandidate> circleCandidates(
    int circleId,
    CircleCandidatesFilter? filter,
  ) async {
    final res = await _voteCircleApi.fetchCircleCandidates(
      circleId,
      filter?.toApiCircleCandidatesFilter(),
    );
    return CircleCandidate.fromApiCircleCandidate(res);
  }

  @override
  Future<CircleVoter> circleVoters(int circleId) async {
    final res = await _voteCircleApi.fetchCircleVoters(circleId);
    return CircleVoter.fromApiCircleVoter(res);
  }

  @override
  Future<Circle> createCircle(CircleCreateRequest circleRequest) async {
    final res = await _voteCircleApi.createCircle(
      circleRequest.toApiCircleCreateRequest(),
    );
    return Circle.fromApiCircle(res);
  }

  @override
  Future<Circle> updateCircle(
      int circleId, CircleUpdateRequest circleUpdateRequest) async {
    final res = await _voteCircleApi.updateCircle(
      circleId,
      circleUpdateRequest.toApiCircleUpdateRequest(),
    );
    return Circle.fromApiCircle(res);
  }

  @override
  Future<void> deleteCircle(int circleId) async {
    return await _voteCircleApi.deleteCircle(
      circleId,
    );
  }

  @override
  Future<bool> eligibleToBeInCircle(int circleId) async {
    return await _voteCircleApi.eligibleToBeInCircle(
      circleId,
    );
  }

  @override
  Future<Candidate> joinCircleAsCandidate(int circleId) async {
    final res = await _voteCircleApi.joinCircleAsCandidate(circleId);
    return Candidate.fromApiCandidate(res);
  }

  @override
  Future<Voter> joinCircleAsVoter(int circleId) async {
    final res = await _voteCircleApi.joinCircleAsVoter(circleId);
    return Voter.fromApiVoter(res);
  }

  @override
  Future<String> leaveCircleAsCandidate(int circleId) async {
    return await _voteCircleApi.leaveCircleAsCandidate(circleId);
  }

  @override
  Future<String> leaveCircleAsVoter(int circleId) async {
    return await _voteCircleApi.leaveCircleAsVoter(circleId);
  }

  @override
  Future<bool> createVote(
      int circleId, VoteCreateRequest voteCreateRequest) async {
    return await _voteCircleApi.createVote(
      circleId,
      voteCreateRequest.toApiVoteCreateRequest(),
    );
  }

  @override
  Future<bool> revokeVote(int circleId) async {
    return await _voteCircleApi.revokeVote(circleId);
  }

  @override
  Future<Commitment> updateCommitment(
    int circleId,
    CircleCandidateCommitmentRequest commitmentRequest,
  ) async {
    final res = await _voteCircleApi.updateCommitment(
      circleId,
      commitmentRequest.toApiCircleCandidateCommitmentRequest(),
    );
    return commitmentFromApiCommitment(res);
  }

  @override
  Future<UserOption> userOption() async {
    final res = await _voteCircleApi.fetchUserOption();
    return UserOption.fromApiUserOption(res);
  }

  @override
  Future<List<String>> circleCandidateVotedBy(
      int circleId, CandidateRequest candidateRequest) async {
    return await _voteCircleApi.fetchCircleCandidateVotedBy(
      circleId,
      candidateRequest.toApiCandidateRequest(),
    );
  }

  @override
  Future<String> removeCandidateFromCircle(
    int circleId,
    CandidateRequest candidateRequest,
  ) async {
    return await _voteCircleApi.removeCandidateFromCircle(
      circleId,
      candidateRequest.toApiCandidateRequest(),
    );
  }

  @override
  Future<String> removeVoterFromCircle(
    int circleId,
    VoterRequest voterRequest,
  ) async {
    return await _voteCircleApi.removeVoterFromCircle(
      circleId,
      voterRequest.toApiVoterRequest(),
    );
  }

  @override
  Future<String> uploadCircleImage(
    int circleId,
    Uint8List imageBytes,
  ) async {
    return await _voteCircleApi.uploadCircleImage(
      circleId,
      imageBytes,
    );
  }

  @override
  Future<void> subscribeToCircleCandidateChangedEvent(int circleId) async {
    try {
      if (_candidateChangedEventSubscription != null) {
        await _candidateChangedEventSubscription?.cancel();
      }

      final channel = _ablyService.channel('circle-$circleId:candidate');
      _candidateChangedEventSubscription = channel
          .subscribe(name: 'circle-candidate-changed')
          .map((event) => CircleCandidateChangeEvent.fromEventData(event.data))
          .listen((data) => _candidateChangedEventController.add(data));
    } catch (e) {
      log.t('subscribeToCircleCandidateChangedEvent', error: e);
    }
  }

  @override
  Future<void> subscribeToCircleVoterChangedEvent(int circleId) async {
    try {
      if (_voterChangedEventSubscription != null) {
        await _voterChangedEventSubscription?.cancel();
      }

      final channel = _ablyService.channel('circle-$circleId:voter');
      _voterChangedEventSubscription = channel
          .subscribe(name: 'circle-voter-changed')
          .map((event) => CircleVoterChangeEvent.fromEventData(event.data))
          .listen((data) => _voterChangedEventController.add(data));
    } catch (e) {
      log.t('subscribeToCircleVoterChangedEvent', error: e);
    }
  }

  @override
  Stream<CircleCandidateChangeEvent> get watchCircleCandidateChangedEvent {
    return _candidateChangedEventController.stream;
  }

  @override
  Stream<CircleVoterChangeEvent> get watchCircleVoterChangedEvent {
    return _voterChangedEventController.stream;
  }

  @override
  void dispose() {
    _candidateChangedEventSubscription?.cancel();
    _voterChangedEventSubscription?.cancel();
  }
}
