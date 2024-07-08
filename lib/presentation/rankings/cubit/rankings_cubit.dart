import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'rankings_state.dart';

class RankingsCubit extends Cubit<RankingsState> {
  RankingsCubit({
    required IVoteCircleRepository voteCircleRepository,
    required IRankingsRepository rankingsRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        _rankingsRepository = rankingsRepository,
        super(const RankingsState()) {
    _initialRankingsLoaded();

    _addedCircleToViewedRankingsSubscription =
        _rankingsRepository.watchAddedCircleToViewedRankings.listen(
      (circleId) => _addedToRankings(int.parse(circleId)),
    );
  }

  final IVoteCircleRepository _voteCircleRepository;
  final IRankingsRepository _rankingsRepository;
  late StreamSubscription<String> _addedCircleToViewedRankingsSubscription;

  @override
  Future<void> close() {
    _addedCircleToViewedRankingsSubscription.cancel();
    _rankingsRepository.dispose();
    return super.close();
  }

  void _initialRankingsLoaded() async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final viewedCircleIds = _rankingsRepository.viewedRankings;

      final circleRequests = viewedCircleIds
          .map((id) => _voteCircleRepository.circle(int.parse(id)));

      final circles = await Future.wait(circleRequests);
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          circles: circles,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _addedToRankings(int circleId) async {
    try {
      final circle = await _voteCircleRepository.circle(circleId);
      final circles = List.of(state.circles);

      if (circles.length >= _rankingsRepository.maxLengthViewedRankings) {
        circles.removeLast();
      }

      circles.insert(0, circle);

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          circles: circles,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
