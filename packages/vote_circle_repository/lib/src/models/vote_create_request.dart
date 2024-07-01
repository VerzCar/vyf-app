import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

class VoteCreateRequest extends Equatable {
  final String candidateId;

  const VoteCreateRequest({
    required this.candidateId,
  });

  vote_circle_api.VoteCreateRequest toApiVoteCreateRequest() =>
      vote_circle_api.VoteCreateRequest(
        candidateId: candidateId,
      );

  @override
  List<Object> get props => [
        candidateId,
      ];
}
