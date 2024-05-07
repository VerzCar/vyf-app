import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const MembersState()) {
    on<CircleMembersInitialLoaded>(_onCircleMembersInitialLoaded);
    on<RankingMembersInitialLoaded>(_onRankingMembersInitialLoaded);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onCircleMembersInitialLoaded(
    CircleMembersInitialLoaded event,
    Emitter<MembersState> emit,
  ) async {
    final currentCircleId = event.context.read<CircleBloc>().state.circle.id;

    if (currentCircleId == state.circleRefId) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final (voters, candidates) = await (
        _voteCircleRepository.circleVoters(event.circleId),
        _voteCircleRepository.circleCandidates(event.circleId, null),
      ).wait;

      emit(state.copyWith(
        circleVoter: voters,
        circleCandidate: candidates,
        circleRefId: event.circleId,
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onRankingMembersInitialLoaded(
    RankingMembersInitialLoaded event,
    Emitter<MembersState> emit,
  ) async {
    final currentCircleId = event.context.read<CircleBloc>().state.circle.id;

    if (currentCircleId == state.circleRankingsRefId) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final candidatesFilter = CircleCandidatesFilter(
        hasBeenVoted: false,
      );

      final (voters, candidates) = await (
        _voteCircleRepository.circleVoters(event.circleId),
        _voteCircleRepository.circleCandidates(
          event.circleId,
          candidatesFilter,
        ),
      ).wait;
      print('HERE');
print(candidates.candidates.length);
      emit(state.copyWith(
        rankingVoter: voters,
        rankingCandidate: candidates,
        circleRankingsRefId: event.circleId,
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
