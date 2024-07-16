import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

enum Commitment {
  open,
  committed,
  rejected,
}

extension CommitmentX on Commitment {
  bool get notCommitted => this != Commitment.committed;
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

Commitment commitmentFromEvent(String commitment) {
  switch (commitment) {
    case 'OPEN':
      return Commitment.open;
    case 'COMMITTED':
      return Commitment.committed;
    case 'REJECTED':
      return Commitment.rejected;
    default:
      throw Exception('casting of commitment event failed.');
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
