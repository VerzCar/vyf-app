import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const MembersState()) {
    on<CircleMembersReset>(_onCircleMembersReset);
    on<CircleMembersInitialLoaded>(_onCircleMembersInitialLoaded);
    on<RankingMembersInitialLoaded>(_onRankingMembersInitialLoaded);
    on<CircleMembersCandidateChanged>(_onCircleCandidateChanged);
    on<CircleMembersVoterChanged>(_onCircleVoterChanged);
    on<CircleMembersRemovedCandidateFromCircle>(_onRemovedCandidateFromCircle);
    on<CircleMembersRemovedVoterFromCircle>(_onRemovedVoterFromCircle);

    _circleCandidateChangeEventSubscription =
        _voteCircleRepository.watchCircleCandidateChangedEvent.listen(
      (event) => add(CircleMembersCandidateChanged(changeEvent: event)),
    );
    _circleVoterChangeEventSubscription =
        _voteCircleRepository.watchCircleVoterChangedEvent.listen(
      (event) => add(CircleMembersVoterChanged(changeEvent: event)),
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
    try {
      if (event.currentCircleId == state.circleRankingsRefId) return;

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
    CircleMembersCandidateChanged event,
    Emitter<MembersState> emit,
  ) {
    try {
      final changeEvent = event.changeEvent;

      // TODO: handle self made updates of user (user id == candidate id)
      switch (changeEvent.operation) {
        case EventOperation.created:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            candidates.add(changeEvent.candidate);

            emit(state.copyWith(
              circleCandidate:
                  state.circleCandidate.copyWith(candidates: candidates),
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.updated:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            final candidateIndex = candidates.indexWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            if (candidateIndex == -1) {
              break;
            }

            candidates[candidateIndex] = changeEvent.candidate;

            emit(state.copyWith(
              circleCandidate:
                  state.circleCandidate.copyWith(candidates: candidates),
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.deleted:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            candidates.removeWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            emit(state.copyWith(
              circleCandidate:
                  state.circleCandidate.copyWith(candidates: candidates),
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
    CircleMembersVoterChanged event,
    Emitter<MembersState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final changeEvent = event.changeEvent;

      // TODO: handle self made updates of user (user id == candidate id)
      switch (changeEvent.operation) {
        case EventOperation.created:
          {
            final voters = List.of(state.circleVoter.voters);
            voters.add(changeEvent.voter);

            emit(state.copyWith(
              circleVoter: state.circleVoter.copyWith(voters: voters),
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.updated:
          {
            final voters = List.of(state.circleVoter.voters);
            final voterIndex =
                voters.indexWhere((voter) => voter.id == changeEvent.voter.id);

            if (voterIndex == -1) {
              break;
            }


            voters[voterIndex] = changeEvent.voter;

            emit(state.copyWith(
              circleVoter: state.circleVoter.copyWith(voters: voters),
              status: StatusIndicator.success,
            ));
            break;
          }
        case EventOperation.deleted:
          {
            final voters = List.of(state.circleVoter.voters);
            voters.removeWhere((voter) => voter.id == changeEvent.voter.id);

            emit(state.copyWith(
              circleVoter: state.circleVoter.copyWith(voters: voters),
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
      print(e);
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
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
