// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:user_repository/user_repository.dart';
// import 'package:vote_circle_repository/vote_circle_repository.dart';
// import 'package:vote_your_face/application/shared/shared.dart';
//
// part 'rankings_event.dart';
//
// part 'ranking_state.dart';
//
// class RankingsBloc extends Bloc<RankingsEvent, RankingsState> {
//   RankingsBloc({
//     required IVoteCircleRepository voteCircleRepository,
//     required IUserRepository userRepository,
//   })  : _voteCircleRepository = voteCircleRepository,
//         super(const RankingsState()) {
//     on<RankingCircleSelected>(_onRankingCircleSelected);
//     on<CircleForRankingsDefined>(_onCircleForRankingsDefined);
//   }
//
//   final IVoteCircleRepository _voteCircleRepository;
//
//   void _onRankingCircleSelected(
//     RankingCircleSelected event,
//     Emitter<RankingsState> emit,
//   ) async {
//     if (event.circleId == null) {
//       return emit(state.copyWith(status: StatusIndicator.initial));
//     }
//
//     emit(state.copyWith(status: StatusIndicator.loading));
//
//     try {
//       final circle = await _voteCircleRepository.circle(event.circleId!);
//       emit(state.copyWith(
//           selectedCircle: circle, status: StatusIndicator.success));
//     } catch (e) {
//       print(e);
//       if (isClosed) return;
//       emit(state.copyWith(status: StatusIndicator.failure));
//     }
//   }
//
//   void _onCircleForRankingsDefined(
//     CircleForRankingsDefined event,
//     Emitter<RankingsState> emit,
//   ) async {
//     //emit(state.copyWith(status: StatusIndicator.loading));
//
//     try {
//       final rankings = await _voteCircleRepository.rankings(event.circleId);
//       emit(state.copyWith(rankings: rankings));
//     } catch (e) {
//       print(e);
//       if (isClosed) return;
//       emit(state.copyWith(status: StatusIndicator.failure));
//     }
//   }
// }
