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
    on<MembersInitialLoaded>(_onMembersInitialLoaded);
    on<MembersStartCandidateChangedEvent>(
      _onMembersStartCandidateChangedEvent,
      transformer: restartable(),
    );
    on<MembersStartVoterChangedEvent>(
      _onMembersStartVoterChangedEvent,
      transformer: restartable(),
    );
    on<MembersRemovedCandidateFromCircle>(_onRemovedCandidateFromCircle);
    on<MembersRemovedVoterFromCircle>(_onRemovedVoterFromCircle);
    on<MembersAddedCandidatesToCircle>(_onMembersAddedCandidatesToCircle);
    on<MembersAddedVotersToCircle>(_onMembersAddedVotersToCircle);
  }

  final IVoteCircleRepository _voteCircleRepository;
  static const int _previewMemberCount = 3;

  @override
  Future<void> close() {
    _voteCircleRepository.dispose();
    return super.close();
  }

  void _onMembersInitialLoaded(
    MembersInitialLoaded event,
    Emitter<MembersState> emit,
  ) async {
    try {
      if (event.currentCircleId == state.circleRefId) return;

      emit(state.copyWith(status: StatusIndicator.loading));

      final (voter, candidate) = await (
        _voteCircleRepository.circleVoters(event.circleId),
        _voteCircleRepository.circleCandidates(
          event.circleId,
          event.filter,
        ),
      ).wait;

      final previewMemberIds = _firstMemberIds(voter, candidate);
      final previewCandidateMemberIds = _firstCandidateMemberIds(candidate);
      final countOfMembers = _countOfRemainingMembers(voter, candidate);
      final countOfCandidateMembers =
          _countOfRemainingCandidateMembers(candidate);

      emit(state.copyWith(
        circleVoter: voter,
        circleCandidate: candidate,
        previewMemberIds: previewMemberIds,
        previewCandidateMemberIds: previewCandidateMemberIds,
        countOfMembers: countOfMembers,
        countOfCandidateMembers: countOfCandidateMembers,
        circleRefId: event.circleId,
        status: StatusIndicator.success,
      ));
    } catch (e) {
      sl<Logger>().t(
        '_onMembersInitialLoaded',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onMembersStartCandidateChangedEvent(
    MembersStartCandidateChangedEvent event,
    Emitter<MembersState> emit,
  ) async {
    await emit.forEach(
      _voteCircleRepository.watchCircleCandidateChangedEvent,
      onData: (changeEvent) => _candidateChanged(
        changeEvent: changeEvent,
        currentUserIdentityId: event.currentUserIdentityId,
      ),
      onError: (object, stackTrace) {
        sl<Logger>().t(
          '_onMembersStartCandidateChangedEvent',
          error: object,
          stackTrace: stackTrace,
        );
        return state;
      },
    );
  }

  void _onMembersStartVoterChangedEvent(
    MembersStartVoterChangedEvent event,
    Emitter<MembersState> emit,
  ) async {
    await emit.forEach(
      _voteCircleRepository.watchCircleVoterChangedEvent,
      onData: (changeEvent) => _voterChanged(
        changeEvent: changeEvent,
        currentUserIdentityId: event.currentUserIdentityId,
      ),
      onError: (object, stackTrace) {
        sl<Logger>().t(
          '_onMembersStartVoterChangedEvent',
          error: object,
          stackTrace: stackTrace,
        );
        return state;
      },
    );
  }

  void _onRemovedCandidateFromCircle(
    MembersRemovedCandidateFromCircle event,
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
    MembersRemovedVoterFromCircle event,
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

  void _onMembersAddedCandidatesToCircle(
    MembersAddedCandidatesToCircle event,
    Emitter<MembersState> emit,
  ) async {
    try {
      final requests = event.candidateIdentIds
          .map((id) => CandidateRequest(candidate: id))
          .toList();

      await _voteCircleRepository.addCandidatesToCircle(
        event.currentCircleId,
        requests,
      );
    } catch (e) {
      sl<Logger>().t(
        '_onMembersAddedCandidatesToCircle',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onMembersAddedVotersToCircle(
    MembersAddedVotersToCircle event,
    Emitter<MembersState> emit,
  ) async {
    try {
      final requests =
          event.voterIdentIds.map((id) => VoterRequest(voter: id)).toList();

      await _voteCircleRepository.addVotersToCircle(
        event.currentCircleId,
        requests,
      );
    } catch (e) {
      sl<Logger>().t(
        '_onMembersAddedVotersToCircle',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  MembersState _candidateChanged({
    required CircleCandidateChangeEvent changeEvent,
    required String currentUserIdentityId,
  }) {
    sl<Logger>().i('${changeEvent.candidate} : ${changeEvent.operation}');
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

            final circleCandidate = state.circleCandidate.copyWith(
              candidates: candidates,
              userCandidate: () => userCandidate,
            );

            final previewMemberIds = _firstMemberIds(
              state.circleVoter,
              circleCandidate,
            );
            final previewCandidateMemberIds = _firstCandidateMemberIds(
              circleCandidate,
            );
            final countOfMembers = _countOfRemainingMembers(
              state.circleVoter,
              circleCandidate,
            );
            final countOfCandidateMembers =
                _countOfRemainingCandidateMembers(circleCandidate);

            return state.copyWith(
              circleCandidate: circleCandidate,
              previewMemberIds: previewMemberIds,
              previewCandidateMemberIds: previewCandidateMemberIds,
              countOfMembers: countOfMembers,
              countOfCandidateMembers: countOfCandidateMembers,
              status: StatusIndicator.success,
            );
          }
        case EventOperation.updated:
          {
            final candidates = List.of(state.circleCandidate.candidates);
            final candidateIndex = candidates.indexWhere(
                (candidate) => candidate.id == changeEvent.candidate.id);

            if (candidateIndex == -1) {
              return state;
            }

            var userCandidate = state.circleCandidate.userCandidate;

            if (changeEvent.candidate.candidate == currentUserIdentityId) {
              userCandidate = changeEvent.candidate;
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

            final circleCandidate = state.circleCandidate.copyWith(
              candidates: candidates,
              userCandidate: () => userCandidate,
            );

            final previewMemberIds = _firstMemberIds(
              state.circleVoter,
              circleCandidate,
            );
            final previewCandidateMemberIds = _firstCandidateMemberIds(
              circleCandidate,
            );
            final countOfMembers = _countOfRemainingMembers(
              state.circleVoter,
              circleCandidate,
            );
            final countOfCandidateMembers =
                _countOfRemainingCandidateMembers(circleCandidate);

            return state.copyWith(
              circleCandidate: circleCandidate,
              previewMemberIds: previewMemberIds,
              previewCandidateMemberIds: previewCandidateMemberIds,
              countOfMembers: countOfMembers,
              countOfCandidateMembers: countOfCandidateMembers,
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
        '_candidateChanged',
        error: e,
      );
      if (isClosed) return state;
      return state.copyWith(status: StatusIndicator.success);
    }
  }

  MembersState _voterChanged({
    required CircleVoterChangeEvent changeEvent,
    required String currentUserIdentityId,
  }) {
    sl<Logger>().i('${changeEvent.voter} : ${changeEvent.operation}');
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

            final circleVoter = state.circleVoter.copyWith(
              voters: voters,
              userVoter: () => userVoter,
            );

            final previewMemberIds = _firstMemberIds(
              circleVoter,
              state.circleCandidate,
            );
            final countOfMembers = _countOfRemainingMembers(
              circleVoter,
              state.circleCandidate,
            );

            return state.copyWith(
              circleVoter: circleVoter,
              previewMemberIds: previewMemberIds,
              countOfMembers: countOfMembers,
              status: StatusIndicator.success,
            );
          }
        case EventOperation.updated:
          {
            final voters = List.of(state.circleVoter.voters);
            final voterIndex =
                voters.indexWhere((voter) => voter.id == changeEvent.voter.id);

            if (voterIndex == -1) {
              return state;
            }

            var userVoter = state.circleVoter.userVoter;

            if (changeEvent.voter.voter == currentUserIdentityId) {
              userVoter = changeEvent.voter;
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

            final circleVoter = state.circleVoter.copyWith(
              voters: voters,
              userVoter: () => userVoter,
            );

            final previewMemberIds = _firstMemberIds(
              circleVoter,
              state.circleCandidate,
            );
            final countOfMembers = _countOfRemainingMembers(
              circleVoter,
              state.circleCandidate,
            );

            return state.copyWith(
              circleVoter: circleVoter,
              previewMemberIds: previewMemberIds,
              countOfMembers: countOfMembers,
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
        '_voterChanged',
        error: e,
      );
      if (isClosed) return state;
      return state.copyWith(status: StatusIndicator.success);
    }
  }

  List<String> _firstMemberIds(
    CircleVoter circleVoter,
    CircleCandidate circleCandidate,
  ) {
    return [
      ...circleVoter.voters,
      ...circleCandidate.candidates,
    ].take(_previewMemberCount).map((member) {
      if (member is Voter) {
        return member.voter;
      }

      if (member is Candidate) {
        return member.candidate;
      }

      throw ArgumentError.value(member);
    }).toList();
  }

  List<String> _firstCandidateMemberIds(
    CircleCandidate circleCandidate,
  ) {
    return circleCandidate.candidates
        .take(_previewMemberCount)
        .map((member) => member.candidate)
        .toList();
  }

  int _countOfRemainingMembers(
    CircleVoter circleVoter,
    CircleCandidate circleCandidate,
  ) {
    return (circleVoter.voters.length + circleCandidate.candidates.length) -
        _previewMemberCount;
  }

  int _countOfRemainingCandidateMembers(CircleCandidate circleCandidate) {
    return circleCandidate.candidates.length - _previewMemberCount;
  }
}
