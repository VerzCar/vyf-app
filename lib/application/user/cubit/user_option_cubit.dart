import 'package:bloc/bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'user_option_state.dart';

class UserOptionCubit extends Cubit<UserOptionState> {
  UserOptionCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const UserOptionState());

  final IVoteCircleRepository _voteCircleRepository;

  void reset() {
    emit(state.reset());
  }

  void userOptionLoaded() async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final userOption = await _voteCircleRepository.userOption();
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          userOption: userOption,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
