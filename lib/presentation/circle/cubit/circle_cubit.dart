import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'circle_state.dart';

class CircleCubit extends Cubit<CircleState> {
  CircleCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleState());

  final IVoteCircleRepository _voteCircleRepository;

  Future<void> selectCircle(int id) async {
    if (state.circle.id == id) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final circle = await _voteCircleRepository.circle(id);
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          circle: circle,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
