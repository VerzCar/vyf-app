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

    return memberState.circleCandidate.userCandidate?.candidate == userIdentityId;
  }

  static bool isUserVoterMemberOfCircle(
    MembersState memberState,
    String userIdentityId,
  ) {
    if (memberState.status.isNotSuccessful) {
      return false;
    }

    return memberState.circleVoter.userVoter?.voter == userIdentityId;
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

  static bool canRevokeVote(
      MembersState memberState,
      String toVoteForIdentityId,
      ) {
    if (memberState.status.isNotSuccessful) {
      return false;
    }

    // The member (myself) must be a voter to be able to revoke the vote
    if (memberState.circleVoter.userVoter == null) {
      return false;
    }

    // voter hasn't voted yet
    if (memberState.circleVoter.userVoter!.votedFor == null) {
      return false;
    }

    // voter has voted for given user id
    return memberState.circleVoter.userVoter!.votedFor == toVoteForIdentityId;
  }
}
