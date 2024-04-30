import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'members_event.dart';

part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const MembersState()) {
    on<MembersInitialLoaded>(_onMembersInitialLoaded);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onMembersInitialLoaded(
    MembersInitialLoaded event,
    Emitter<MembersState> emit,
  ) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final (voters, candidates) = await (
        _voteCircleRepository.circleVoters(event.circleId),
        _voteCircleRepository.circleCandidates(event.circleId),
      ).wait;

      emit(state.copyWith(
        circleVoter: voters,
        circleCandidate: candidates,
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
