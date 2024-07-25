import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'rankings_state.dart';

class RankingsCubit extends Cubit<RankingsState> {
  RankingsCubit({
    required IVoteCircleRepository voteCircleRepository,
    required IRankingsRepository rankingsRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        _rankingsRepository = rankingsRepository,
        super(const RankingsState()) {
    _initialRankingsLoaded();
  }

  final IVoteCircleRepository _voteCircleRepository;
  final IRankingsRepository _rankingsRepository;
  static const _maxLengthViewedRankings = 15;

  @override
  Future<void> close() {
    _rankingsRepository.dispose();
    return super.close();
  }

  void _initialRankingsLoaded() async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final lastViewed = await _voteCircleRepository.rankingsLastViewed();
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          lastViewed: lastViewed,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        '_initialRankingsLoaded',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  /// Add the visited circle to viewed rankings
  void addToViewedRankings(int circleId) async {
    try {
      final lastViewed = List.of(state.lastViewed);

      final existingLastViewedRankingIndex =
          lastViewed.indexWhere((ranking) => ranking.circle.id == circleId);

      if (existingLastViewedRankingIndex != -1) {
        return;
      }

      final circle = await _voteCircleRepository.circle(circleId);

      final id = (lastViewed.lastOrNull?.id ?? 0) + 1;
      final rankingLastViewed = RankingLastViewed(
        id: id,
        circle: CirclePaginated(
          id: circle.id,
          name: circle.name,
          description: circle.description,
          imageSrc: circle.imageSrc,
          active: circle.active,
          stage: circle.stage,
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (lastViewed.length >= _maxLengthViewedRankings) {
        lastViewed.removeLast();
      }

      lastViewed.insert(0, rankingLastViewed);

      emit(
        state.copyWith(
          lastViewed: lastViewed,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        'addToViewedRankings',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
