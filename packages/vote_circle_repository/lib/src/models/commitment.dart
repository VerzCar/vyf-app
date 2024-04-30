import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

enum Commitment {
  open,
  committed,
  rejected,
}

Commitment commitmentFromApiCommitment(vote_circle_api.Commitment commitment) {
  switch (commitment) {
    case vote_circle_api.Commitment.open:
      return Commitment.open;
    case vote_circle_api.Commitment.committed:
      return Commitment.committed;
    case vote_circle_api.Commitment.rejected:
      return Commitment.rejected;
  }
}
