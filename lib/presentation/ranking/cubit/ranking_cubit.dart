import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:rankings_repository/rankings_repository.dart' as rankings_repo;
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'ranking_state.dart';

class RankingCubit extends Cubit<RankingState> {
  RankingCubit({
    required IVoteCircleRepository voteCircleRepository,
    required rankings_repo.IRankingsRepository rankingsRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        _rankingsRepository = rankingsRepository,
        super(const RankingState()) {
    _rankingChangeEventSubscription =
        _rankingsRepository.watchRankingChangedEvent.listen(
      (event) => _onRankingChanged(changeEvent: event),
    );
  }

  final IVoteCircleRepository _voteCircleRepository;
  final rankings_repo.IRankingsRepository _rankingsRepository;
  late StreamSubscription<rankings_repo.RankingChangeEvent>
      _rankingChangeEventSubscription;

  @override
  Future<void> close() {
    _rankingChangeEventSubscription.cancel();
    return super.close();
  }

  void loadRankings(int circleId) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final rankings = await _voteCircleRepository.rankings(circleId);

      await Future.wait([
        _rankingsRepository.subscribeToRankingChangedEvent(circleId),
        _voteCircleRepository.subscribeToCircleCandidateChangedEvent(circleId),
        _voteCircleRepository.subscribeToCircleVoterChangedEvent(circleId),
      ]);

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          rankings: rankings,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        'loadRankings',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void addToViewedRankings(int circleId) {
    try {
      _rankingsRepository.addToViewedRankings(circleId.toString());
    } catch (e) {
      sl<Logger>().t(
        'addToViewedRankings',
        error: e,
      );
    }
  }

  void _onRankingChanged({
    required rankings_repo.RankingChangeEvent changeEvent,
  }) {
    sl<Logger>().i('${changeEvent.ranking} : ${changeEvent.operation}');
    try {
      switch (changeEvent.operation) {
        case rankings_repo.EventOperation.created:
        case rankings_repo.EventOperation.updated:
          {
            final rankings = List.of(state.rankings);
            final rankingIndex = rankings
                .indexWhere((ranking) => ranking.id == changeEvent.ranking.id);

            if (rankingIndex != -1) {
              rankings.removeAt(rankingIndex);
            }

            final mappedRanking = Ranking(
              id: changeEvent.ranking.id,
              candidateId: changeEvent.ranking.candidateId,
              identityId: changeEvent.ranking.identityId,
              number: changeEvent.ranking.number,
              votes: changeEvent.ranking.votes,
              indexedOrder: changeEvent.ranking.indexedOrder,
              // TODO: add placement mapping from eventing
              placement: Placement.neutral,
              circleId: changeEvent.ranking.circleId,
              createdAt: changeEvent.ranking.createdAt,
              updatedAt: changeEvent.ranking.updatedAt,
            );

            rankings.insert(changeEvent.ranking.indexedOrder, mappedRanking);

            emit(state.copyWith(
              rankings: rankings,
              status: StatusIndicator.success,
            ));
            break;
          }
        case rankings_repo.EventOperation.deleted:
          {
            final rankings = List.of(state.rankings);
            rankings
                .removeWhere((ranking) => ranking.id == changeEvent.ranking.id);

            emit(state.copyWith(
              rankings: rankings,
              status: StatusIndicator.success,
            ));
            break;
          }
        case rankings_repo.EventOperation.repositioned:
          {
            break;
          }
      }
    } catch (e) {
      sl<Logger>().t(
        '_onRankingChanged',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.success));
    }
  }
}
