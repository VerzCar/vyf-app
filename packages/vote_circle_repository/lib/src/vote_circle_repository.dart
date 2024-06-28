import 'dart:async';

import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';
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
  final StreamController<CircleCandidateChangeEvent>
      _candidateChangedEventController =
      StreamController<CircleCandidateChangeEvent>();
  StreamSubscription<CircleCandidateChangeEvent>?
      _candidateChangedEventSubscription;
  final StreamController<CircleVoterChangeEvent>
  _voterChangedEventController =
  StreamController<CircleVoterChangeEvent>();
  StreamSubscription<CircleVoterChangeEvent>?
  _voterChangedEventSubscription;

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
  void subscribeToCircleCandidateChangedEvent(int circleId) {
    try {
      if (_candidateChangedEventSubscription != null) {
        _candidateChangedEventSubscription?.cancel();
      }

      final channel = _ablyService.channel('circle-$circleId:candidate');
      _candidateChangedEventSubscription = channel
          .subscribe(name: 'circle-candidate-changed')
          .map((event) => CircleCandidateChangeEvent.fromEventData(event.data))
          .listen((data) => _candidateChangedEventController.add(data));
    } catch (e) {
      print('subscribeToCircleCandidateChangedEvent ERROR +++++++++++');
      print(e);
    }
  }

  @override
  void subscribeToCircleVoterChangedEvent(int circleId) {
    try {
      if (_voterChangedEventSubscription != null) {
        _voterChangedEventSubscription?.cancel();
      }

      final channel = _ablyService.channel('circle-$circleId:voter');
      _voterChangedEventSubscription = channel
          .subscribe(name: 'circle-voter-changed')
          .map((event) => CircleVoterChangeEvent.fromEventData(event.data))
          .listen((data) => _voterChangedEventController.add(data));
    } catch (e) {
      print('subscribeToCircleVoterChangedEvent ERROR +++++++++++');
      print(e);
    }
  }

  @override
  Stream<CircleCandidateChangeEvent> get circleCandidateChangedEvent async* {
    yield* _candidateChangedEventController.stream;
  }

  @override
  Stream<CircleVoterChangeEvent> get circleVoterChangedEvent async* {
    yield* _voterChangedEventController.stream;
  }

  @override
  void dispose() {
    _candidateChangedEventController.close();
    _voterChangedEventController.close();
    _candidateChangedEventSubscription?.cancel();
    _voterChangedEventSubscription?.cancel();
    _ablyService.dispose();
  }
}
