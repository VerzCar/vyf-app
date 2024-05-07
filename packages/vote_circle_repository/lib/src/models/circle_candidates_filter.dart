import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

import 'commitment.dart';

class CircleCandidatesFilter {
  CircleCandidatesFilter({
    this.commitment,
    this.hasBeenVoted,
  });

  final Commitment? commitment;
  final bool? hasBeenVoted;

  vote_circle_api.CircleCandidatesFilter toApiCircleCandidatesFilter() {
    return vote_circle_api.CircleCandidatesFilter(
      commitment:
          commitment != null ? commitmentToApiCommitment(commitment!) : null,
      hasBeenVoted: hasBeenVoted,
    );
  }
}
