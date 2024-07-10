part of 'members_bloc.dart';

final class MembersState extends VyfBaseState {
  const MembersState({
    this.status = StatusIndicator.initial,
    this.circleVoter = CircleVoter.empty,
    this.circleCandidate = CircleCandidate.empty,
    this.previewMemberIds = const [],
    this.previewCandidateMemberIds = const [],
    this.countOfMembers = 0,
    this.countOfCandidateMembers = 0,
    this.circleRefId = 0,
  });

  final CircleVoter circleVoter;
  final CircleCandidate circleCandidate;

  /// list of to show preview members (mixed voters and candidates)
  final List<String> previewMemberIds;

  /// list of to show preview members (only candidates)
  final List<String> previewCandidateMemberIds;

  /// amount of members minus the preview members count
  final int countOfMembers;

  /// amount of candidate members minus the preview members count
  final int countOfCandidateMembers;

  /// circle reference id to couple with this members
  final int circleRefId;
  final StatusIndicator status;

  @override
  MembersState copyWith({
    CircleVoter? circleVoter,
    CircleCandidate? circleCandidate,
    List<String>? previewMemberIds,
    List<String>? previewCandidateMemberIds,
    int? countOfMembers,
    int? countOfCandidateMembers,
    int? circleRefId,
    StatusIndicator? status,
  }) {
    return MembersState(
      circleVoter: circleVoter ?? this.circleVoter,
      circleCandidate: circleCandidate ?? this.circleCandidate,
      circleRefId: circleRefId ?? this.circleRefId,
      previewMemberIds: previewMemberIds ?? this.previewMemberIds,
      previewCandidateMemberIds:
          previewCandidateMemberIds ?? this.previewCandidateMemberIds,
      countOfMembers: countOfMembers ?? this.countOfMembers,
      countOfCandidateMembers:
          countOfCandidateMembers ?? this.countOfCandidateMembers,
      status: status ?? this.status,
    );
  }

  @override
  MembersState reset() => const MembersState();

  @override
  List<Object> get props => [
        circleVoter,
        circleCandidate,
        circleRefId,
        previewMemberIds,
        previewCandidateMemberIds,
        countOfMembers,
        countOfCandidateMembers,
        status,
      ];
}
