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

vote_circle_api.Commitment commitmentToApiCommitment(Commitment commitment) {
  switch (commitment) {
    case Commitment.open:
      return vote_circle_api.Commitment.open;
    case Commitment.committed:
      return vote_circle_api.Commitment.committed;
    case Commitment.rejected:
      return vote_circle_api.Commitment.rejected;
  }
}
