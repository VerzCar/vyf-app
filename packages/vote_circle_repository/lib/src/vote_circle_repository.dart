import 'package:authentication_repository/authentication_repository.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'package:vote_circle_repository/src/models/circle_candidate.dart';
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
  Future<List<CircleCandidate>> circleCandidates(int circleId) async {
    final res = await _voteCircleApi.fetchCircleCandidates(circleId);
    final candidates = res
        .map((candidate) => CircleCandidate.fromApiCircleCandidate(candidate))
        .toList();
    return candidates;
  }

  @override
  Future<List<CircleVoter>> circleVoters(int circleId) async {
    final res = await _voteCircleApi.fetchCircleVoters(circleId);
    final voters =
        res.map((voter) => CircleVoter.fromApiCircleVoter(voter)).toList();
    return voters;
  }
}
