import 'dart:async';

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
    on<CircleCandidateChanged>(_onCircleCandidateChanged);
    on<CircleVoterChanged>(_onCircleVoterChanged);

    _circleCandidateChangeEventSubscription =
        _voteCircleRepository.circleCandidateChangedEvent.listen(
      (event) => add(CircleCandidateChanged(changeEvent: event)),
    );
    _circleVoterChangeEventSubscription =
        _voteCircleRepository.circleVoterChangedEvent.listen(
      (event) => add(CircleVoterChanged(changeEvent: event)),
    );
  }

  final IVoteCircleRepository _voteCircleRepository;
  late StreamSubscription<CircleCandidateChangeEvent>
      _circleCandidateChangeEventSubscription;
  late StreamSubscription<CircleVoterChangeEvent>
      _circleVoterChangeEventSubscription;

  @override
  Future<void> close() {
    _circleCandidateChangeEventSubscription.cancel();
    _circleVoterChangeEventSubscription.cancel();
    _voteCircleRepository.dispose();
    return super.close();
  }

  void _onCircleMembersInitialLoaded(
    CircleMembersInitialLoaded event,
    Emitter<MembersState> emit,
  ) async {
    final currentCircleId = event.context.read<CircleBloc>().state.circle.id;

    if (currentCircleId == state.circleRefId) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final (voter, candidate) = await (
        _voteCircleRepository.circleVoters(event.circleId),
        _voteCircleRepository.circleCandidates(event.circleId, null),
      ).wait;

      emit(state.copyWith(
        circleVoter: voter,
        circleCandidate: candidate,
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

      final (voter, candidate) = await (
        _voteCircleRepository.circleVoters(event.circleId),
        _voteCircleRepository.circleCandidates(
          event.circleId,
          candidatesFilter,
        ),
      ).wait;

      emit(state.copyWith(
        rankingVoter: voter,
        rankingCandidate: candidate,
        circleRankingsRefId: event.circleId,
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onCircleCandidateChanged(
    CircleCandidateChanged event,
    Emitter<MembersState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final changeEvent = event.changeEvent;

      // TODO: handle self made updates of user (user id == candidate id)
      switch (changeEvent.operation) {
        case EventOperation.created:
          {
            final circleCandidate = state.circleCandidate;
            circleCandidate.candidates.add(changeEvent.candidate);

            emit(state.copyWith(
              circleCandidate: circleCandidate,
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.updated:
          {
            final circleCandidate = state.circleCandidate;
            final candidateIndex = circleCandidate.candidates.indexWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            if (candidateIndex == -1) {
              break;
            }

            circleCandidate.candidates[candidateIndex] = changeEvent.candidate;

            emit(state.copyWith(
              circleCandidate: circleCandidate,
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.deleted:
          {
            final circleCandidate = state.circleCandidate;
            circleCandidate.candidates.removeWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            emit(state.copyWith(
              circleCandidate: circleCandidate,
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.repositioned:
          {
            break;
          }
      }
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.success));
    }
  }

  void _onCircleVoterChanged(
    CircleVoterChanged event,
    Emitter<MembersState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final changeEvent = event.changeEvent;
print(changeEvent.voter);
print(changeEvent.operation);
      // TODO: handle self made updates of user (user id == candidate id)
      switch (changeEvent.operation) {
        case EventOperation.created:
          {
            final circleVoter = state.circleVoter;
            circleVoter.voters.add(changeEvent.voter);

            emit(state.copyWith(
              circleVoter: circleVoter,
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.updated:
          {
            final circleVoter = state.circleVoter;
            final voterIndex = circleVoter.voters
                .indexWhere((voter) => voter.id == changeEvent.voter.id);

            if (voterIndex == -1) {
              break;
            }

            circleVoter.voters[voterIndex] = changeEvent.voter;

            emit(state.copyWith(
              circleVoter: circleVoter,
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.deleted:
          {
            final circleVoter = state.circleVoter;
            circleVoter.voters
                .removeWhere((voter) => voter.id == changeEvent.voter.id);

            emit(state.copyWith(
              circleVoter: circleVoter,
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.repositioned:
          {
            break;
          }
      }
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.success));
    }
  }
}
