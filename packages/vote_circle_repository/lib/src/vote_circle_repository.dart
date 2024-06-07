import 'package:authentication_repository/authentication_repository.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

import 'i_vote_circle_repository.dart';
import 'models/models.dart';

class VoteCircleRepository implements IVoteCircleRepository {
  VoteCircleRepository({
    required IAuthenticationRepository authenticationRepository,
    vote_circle_api.IVoteCircleApiClient? voteCircleApi,
  }) : _voteCircleApi = voteCircleApi ??
            vote_circle_api.VoteCircleApiClient(
                authenticationRepository: authenticationRepository);

  final vote_circle_api.IVoteCircleApiClient _voteCircleApi;

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
}
