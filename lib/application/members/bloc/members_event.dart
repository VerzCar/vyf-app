part of 'members_bloc.dart';

sealed class MembersEvent extends Equatable {
  const MembersEvent();
}

final class CircleMembersInitialLoaded extends MembersEvent {
  const CircleMembersInitialLoaded({
    required this.circleId,
    required this.context,
  });

  final int circleId;
  final BuildContext context;

  @override
  List<Object> get props => [
        circleId,
      ];
}

final class RankingMembersInitialLoaded extends MembersEvent {
  const RankingMembersInitialLoaded({
    required this.circleId,
    required this.context,
  });

  final int circleId;
  final BuildContext context;

  @override
  List<Object> get props => [
        circleId,
      ];
}

final class CircleCandidateChanged extends MembersEvent {
  const CircleCandidateChanged({
    required this.changeEvent,
  });

  final CircleCandidateChangeEvent changeEvent;

  @override
  List<Object> get props => [
        changeEvent,
      ];
}
