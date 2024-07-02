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

  static bool canVote(
    MembersState memberState,
    String toVoteForIdentityId,
  ) {
    if (memberState.status.isNotSuccessful) {
      return false;
    }

    // The member (myself) must be a voter to be able to vote
    if (memberState.circleVoter.userVoter == null) {
      return false;
    }

    // voter is the same user, cannot vote for himself
    if (memberState.circleVoter.userVoter!.voter == toVoteForIdentityId) {
      return false;
    }

    // voter hasn't voted yet
    return memberState.circleVoter.userVoter!.votedFor == null;
  }
}
