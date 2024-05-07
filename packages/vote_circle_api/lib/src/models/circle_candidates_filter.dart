import 'commitment.dart';

class CircleCandidatesFilter {
  CircleCandidatesFilter({
    this.commitment,
    this.hasBeenVoted,
  });

  final Commitment? commitment;
  final bool? hasBeenVoted;

  Map<String, dynamic> toParamMap() {
    final map = <String, dynamic>{};

    if (commitment != null) {
      map.addAll({'commitment': commitment.toString()});
    }

    if (hasBeenVoted != null) {
      map.addAll({'hasBeenVoted': hasBeenVoted.toString()});
    }

    return map;
  }
}
