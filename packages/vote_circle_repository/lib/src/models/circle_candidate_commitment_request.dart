import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'package:vote_circle_repository/src/models/commitment.dart';

class CircleCandidateCommitmentRequest extends Equatable {
  final Commitment commitment;

  const CircleCandidateCommitmentRequest({
    required this.commitment,
  });

  vote_circle_api.CircleCandidateCommitmentRequest
      toApiCircleCandidateCommitmentRequest() =>
          vote_circle_api.CircleCandidateCommitmentRequest(
            commitment: commitmentToApiCommitment(commitment),
          );

  @override
  List<Object> get props => [
        commitment,
      ];
}
