import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';

class MembersSelector {
  static bool isUserCandidateMemberOfCircle(
    MembersState memberState,
    String userIdentityId,
  ) {
    if (memberState.status.isNotSuccessful) {
      return false;
    }

    if (memberState.circleCandidate.userCandidate?.candidate ==
        userIdentityId) {
      return true;
    }

    final candidateIndex = memberState.circleCandidate.candidates
        .indexWhere((candidate) => candidate.candidate == userIdentityId);

    return candidateIndex > -1;
  }

  static bool isUserVoterMemberOfCircle(
    MembersState memberState,
    String userIdentityId,
  ) {
    if (memberState.status.isNotSuccessful) {
      return false;
    }

    if (memberState.circleVoter.userVoter?.voter == userIdentityId) {
      return true;
    }

    final voterIndex = memberState.circleVoter.voters
        .indexWhere((voter) => voter.voter == userIdentityId);

    return voterIndex > -1;
  }
}
