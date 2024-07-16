import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'user_option_event.dart';
part 'user_option_state.dart';

class UserOptionBloc extends Bloc<UserOptionEvent, UserOptionState> {
  UserOptionBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const UserOptionState()) {
    on<UserOptionLoaded>(_onUserOptionLoaded);
  }

  final IVoteCircleRepository _voteCircleRepository;

  @override
  Future<void> close() {
    _voteCircleRepository.dispose();
    return super.close();
  }

  void _onUserOptionLoaded(
    UserOptionLoaded event,
    Emitter<UserOptionState> emit,
  ) async {
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
      sl<Logger>().t(
        '_onUserOptionLoaded',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
