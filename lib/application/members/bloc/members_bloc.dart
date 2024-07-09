import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const MembersState()) {
    on<CircleMembersReset>(_onCircleMembersReset);
    on<CircleMembersInitialLoaded>(_onCircleMembersInitialLoaded);
    on<CircleMembersStartCandidateChangedEvent>(
      _onCircleMembersStartCandidateChangedEvent,
      transformer: restartable(),
    );
    on<CircleMembersStartVoterChangedEvent>(
      _onCircleMembersStartVoterChangedEvent,
      transformer: restartable(),
    );
    on<CircleMembersRemovedCandidateFromCircle>(_onRemovedCandidateFromCircle);
    on<CircleMembersRemovedVoterFromCircle>(_onRemovedVoterFromCircle);
  }

  final IVoteCircleRepository _voteCircleRepository;

  @override
  Future<void> close() {
    _voteCircleRepository.dispose();
    return super.close();
  }

  void _onCircleMembersReset(
    CircleMembersReset event,
    Emitter<MembersState> emit,
  ) async {
    emit(state.reset());
  }

  void _onCircleMembersInitialLoaded(
    CircleMembersInitialLoaded event,
    Emitter<MembersState> emit,
  ) async {
    try {
      if (event.currentCircleId == state.circleRefId) return;

      emit(state.copyWith(status: StatusIndicator.loading));

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

  void _onCircleMembersStartCandidateChangedEvent(
    CircleMembersStartCandidateChangedEvent event,
    Emitter<MembersState> emit,
  ) async {
    await emit.forEach(
      _voteCircleRepository.watchCircleCandidateChangedEvent,
      onData: (changeEvent) => _circleCandidateChanged(
        changeEvent: changeEvent,
        currentUserIdentityId: event.currentUserIdentityId,
      ),
      onError: (object, stackTrace) {
        sl<Logger>().t(
          '_onCircleMembersStartCandidateChangedEvent',
          error: object,
          stackTrace: stackTrace,
        );
        return state;
      },
    );
  }

  void _onCircleMembersStartVoterChangedEvent(
    CircleMembersStartVoterChangedEvent event,
    Emitter<MembersState> emit,
  ) async {
    await emit.forEach(
      _voteCircleRepository.watchCircleVoterChangedEvent,
      onData: (changeEvent) => _circleVoterChanged(
        changeEvent: changeEvent,
        currentUserIdentityId: event.currentUserIdentityId,
      ),
      onError: (object, stackTrace) {
        sl<Logger>().t(
          '_onCircleMembersStartVoterChangedEvent',
          error: object,
          stackTrace: stackTrace,
        );
        return state;
      },
    );
  }

  void _onRemovedCandidateFromCircle(
    CircleMembersRemovedCandidateFromCircle event,
    Emitter<MembersState> emit,
  ) async {
    try {
      final request = CandidateRequest(candidate: event.candidateIdentId);
      await _voteCircleRepository.removeCandidateFromCircle(
        event.currentCircleId,
        request,
      );
    } catch (e) {
      sl<Logger>().t(
        '_onRemovedCandidateFromCircle',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onRemovedVoterFromCircle(
    CircleMembersRemovedVoterFromCircle event,
    Emitter<MembersState> emit,
  ) async {
    try {
      final request = VoterRequest(voter: event.voterIdentId);
      await _voteCircleRepository.removeVoterFromCircle(
        event.currentCircleId,
        request,
      );
    } catch (e) {
      sl<Logger>().t(
        '_onRemovedVoterFromCircle',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  MembersState _circleCandidateChanged({
    required CircleCandidateChangeEvent changeEvent,
    required String currentUserIdentityId,
  }) {
    try {
      switch (changeEvent.operation) {
        case EventOperation.created:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            candidates.add(changeEvent.candidate);

            Candidate? userCandidate;

            if (changeEvent.candidate.candidate == currentUserIdentityId) {
              userCandidate = changeEvent.candidate;
            }

            return state.copyWith(
              circleCandidate: state.circleCandidate.copyWith(
                candidates: candidates,
                userCandidate: () => userCandidate,
              ),
              status: StatusIndicator.success,
            );
          }
        case EventOperation.updated:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            final candidateIndex = candidates.indexWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            Candidate? userCandidate;

            if (changeEvent.candidate.candidate == currentUserIdentityId) {
              userCandidate = changeEvent.candidate;
            }

            if (candidateIndex == -1 && userCandidate == null) {
              return state;
            }

            if (candidateIndex > -1) {
              candidates[candidateIndex] = changeEvent.candidate;
            }

            candidates[candidateIndex] = changeEvent.candidate;

            return state.copyWith(
              circleCandidate: state.circleCandidate.copyWith(
                candidates: candidates,
                userCandidate: () => userCandidate,
              ),
              status: StatusIndicator.success,
            );
          }
        case EventOperation.deleted:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            candidates.removeWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            var userCandidate = state.circleCandidate.userCandidate;

            if (changeEvent.candidate.candidate == currentUserIdentityId) {
              userCandidate = null;
            }

            return state.copyWith(
              circleCandidate: state.circleCandidate.copyWith(
                candidates: candidates,
                userCandidate: () => userCandidate,
              ),
              status: StatusIndicator.success,
            );
          }
        case EventOperation.repositioned:
          {
            return state;
          }
      }
    } catch (e) {
      sl<Logger>().t(
        '_circleCandidateChanged',
        error: e,
      );
      if (isClosed) return state;
      return state.copyWith(status: StatusIndicator.success);
    }
  }

  MembersState _circleVoterChanged({
    required CircleVoterChangeEvent changeEvent,
    required String currentUserIdentityId,
  }) {
    try {
      switch (changeEvent.operation) {
        case EventOperation.created:
          {
            final voters = List.of(state.circleVoter.voters);
            voters.add(changeEvent.voter);

            Voter? userVoter;

            if (changeEvent.voter.voter == currentUserIdentityId) {
              userVoter = changeEvent.voter;
            }

            return state.copyWith(
              circleVoter: state.circleVoter.copyWith(
                voters: voters,
                userVoter: () => userVoter,
              ),
              status: StatusIndicator.success,
            );
          }
        case EventOperation.updated:
          {
            final voters = List.of(state.circleVoter.voters);
            final voterIndex =
                voters.indexWhere((voter) => voter.id == changeEvent.voter.id);

            Voter? userVoter;

            if (changeEvent.voter.voter == currentUserIdentityId) {
              userVoter = changeEvent.voter;
            }

            if (voterIndex == -1 && userVoter == null) {
              return state;
            }

            if (voterIndex > -1) {
              voters[voterIndex] = changeEvent.voter;
            }

            return state.copyWith(
              circleVoter: state.circleVoter.copyWith(
                voters: voters,
                userVoter: () => userVoter,
              ),
              status: StatusIndicator.success,
            );
          }
        case EventOperation.deleted:
          {
            final voters = List.of(state.circleVoter.voters);
            voters.removeWhere((voter) => voter.id == changeEvent.voter.id);

            var userVoter = state.circleVoter.userVoter;

            if (changeEvent.voter.voter == currentUserIdentityId) {
              userVoter = null;
            }

            return state.copyWith(
              circleVoter: state.circleVoter.copyWith(
                voters: voters,
                userVoter: () => userVoter,
              ),
              status: StatusIndicator.success,
            );
          }
        case EventOperation.repositioned:
          {
            return state;
          }
      }
    } catch (e) {
      sl<Logger>().t(
        '_circleVoterChanged',
        error: e,
      );
      if (isClosed) return state;
      return state.copyWith(status: StatusIndicator.success);
    }
  }
}
